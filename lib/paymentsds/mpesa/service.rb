# frozen_string_literal: true
require 'json'
require 'faraday'
require 'faraday_middleware'

require_relative "errors/errors"

module Paymentsds
  module MPesa
    class Service
      attr_accessor :config

      def initialize
        @config = Paymentsds::MPesa::Configuration.new
      end

      def apply
        @config.apply
      end

      def handle_send(intent)
        operation = detect_operation(intent)
        handle_request(operation, intent)
      end

      def handle_receive(intent)
        handle_request(:C2B_PAYMENT, intent)
      end

      def handle_revert(intent)
        handle_request(:REVERSAL, intent)
      end

      def handle_query(_intent)
        handle_request(:QUERY_TRANSACTION_STATUS, ntent)
      end

      private

      def handle_request(opcode, intent)
        data = fill_optional_properties(opcode, intent)

        missing_properties = detect_missing_properties(opcode, data)
        unless missing_properties.empty?
          return Paymentsds::MPesa::Result.new(false, Paymentsds::MPesa::ErrorType::MISSING_PROPERTIES, missing_properties)
        end

        errors = detect_errors(opcode, data)
        unless errors.empty?
          return Paymentsds::MPesa::Result.new(false, Paymentsds::MPesa::ErrorType::VALIDATION_ERROR, errors)
        end

        perform_request(opcode, intent)
      end

      def detect_operation(intent)
        if intent.key? :to
          case intent[:to]
          when /^((00|\+)?258)?8[45][0-9]{7}$/
            :B2C_PAYMENT
          when /^[0-9]{5,6}$/
            :B2B_PAYMENT
          end
        end

        raise InvalidDestination
      end

      def detect_missing_properties(opcode, intent)
        operation = Paymentsds::MPesa::OPERATIONS[opcode]

        operation[:required] - intent.keys
      end

      def detect_errors(opcode, intent)
        operation = Paymentsds::MPesa::OPERATIONS[opcode]

        errors = []

        intent.each do |k, _v|
          errors.push(k) unless (intent[k]).match operation[:validation][k]
        end

        errors
      end

      def fill_optional_properties(opcode, intent)
        case opcode
        when :C2B_PAYMENT
          intent[:to] = @config.service_provider_code if !intent.key?(:to) && !@config.service_provider_code.nil?
        when :B2B_PAYMENT
          intent[:to] = @config.service_provider_code if !intent.key?(:to) && !@config.service_provider_code.nil?
        when :B2C_PAYMENT
          intent[:from] = @config.service_provider_code if !intent.key?(:from) && !@config.service_provider_code.nil?
        when :REVERSAL
          intent[:to] = @config.service_provider_code if !intent.key?(:to) && !@config.service_provider_code.nil?

          if !intent.key?(:initiator_identifier) && !@config.initiator_identifier.nil?
            intent[:initiator_identifier] = @config.initiator_identifier
          end

          if intent.key?(:security_credential) && !@config.security_credential.nil?
            intent[:security_credential] = @config.security_credential
          end
        when :QUERY_TRANSACTION_STATUS
          intent[:to] = @config.service_provider_code if !intent.key?(:to) && !@config.service_provider_code.nil?
        end

        intent
      end

      def build_request_body(opcode, intent)
        operation = Paymentsds::MPesa::OPERATIONS[opcode]

        body = {}
        operation[:mapping].each do |k, v|
          body[v] = intent[k]
        end

        body
      end

      def build_request_headers
        generate_access_token

        headers = {
          'Authorization': "Bearer #{@config.auth}",
          'Origin': @config.origin,
          'Content-Type': 'application/json',
          'User-Agent': @config.user_agent
        }

        headers
      end

      def perform_request(opcode, intent)
        operation = Paymentsds::MPesa::OPERATIONS[opcode]

        generate_access_token
        
        request_data = {
          base_url: "#{@config.environment.to_url}:#{operation[:port]}",
          url: operation[:path],
          method: operation[:method],
          path: operation[:path],
          headers: build_request_headers,
          timeout: @config.timeout,
          body: build_request_body(opcode, intent)
        }

        http_client = Faraday.new(url: request_data[:base_url]) do |client|
          client.adapter Faraday.default_adapter
          client.headers = request_data[:headers]
          client.response :json
        end

        puts request_data[:base_url]
        
        case operation[:method]    
        when :get
          response = http_client.get(request_data[:path]) do |req|
            req.params = request_data[:body]
            req.options.timeout = request_data[:timeout]
          end

        when :post
          response = http_client.post(request_data[:path]) do |req|
            req.body = request_data[:body].to_json
            req.options.timeout = request_data[:timeout]
          end

        when :put
          response = http_client.put(request_data[:path]) do |req|
            req.body = request_data[:body].to_json
            req.options.timeout = request_data[:timeout]
          end
        end

        build_response(response)
      end

      def build_response(result)

        case result.status
        when 200
          case result.body[:output_ResponseCode]
          when Paymentsds::MPesa::INS0
            response = Paymentsds::MPesa::Result.new(result.success?, nil, result.body)
          else
            raise UnknownError
          end

        when 201
          case result.body[:output_ResponseCode]
          when Paymentsds::MPesa::INS0
            response = Paymentsds::MPesa::Result.new(result.success?, nil, result.body)
          else
            raise UnknownError
          end

        when 400
          case result.body[:output_ResponseCode]
          when Paymentsds::MPesa::INS13
            raise InvalidShortcodeError
          when Paymentsds::MPesa::INS14
            raise InvalidReferenceError
          when Paymentsds::MPesa::INS15
            raise InvalidAmountError
          when Paymentsds::MPesa::INS17
            raise InvalidTransactionReferenceError
          when Paymentsds::MPesa::INS18
            raise InvalidTransactionIdError
          when Paymentsds::MPesa::INS19
            raise InvalidThirdPartyReferenceError
          when Paymentsds::MPesa::INS20
            raise InvalidMissingPropertiesError
          when Paymentsds::MPesa::INS21
            raise ValidationError
          when Paymentsds::MPesa::INS22
            raise InvalidOperationPartError
          when Paymentsds::MPesa::INS23
            raise UnknownStatusError
          when Paymentsds::MPesa::INS24
            raise InvalidInitiatorIdentifierError
          when Paymentsds::MPesa::INS25
            raise InvalidSecurityCredentialError
          when Paymentsds::MPesa::INS993
            raise DirectDebtMissingError
          when Paymentsds::MPesa::INS994
            raise DuplicatedDirectDebtError
          when Paymentsds::MPesa::INS995
            raise ProfileProblemsError
          when Paymentsds::MPesa::INS996
            raise InactiveAccountError
          when Paymentsds::MPesa::INS997
            raise InvalidLanguageCodeError
          when Paymentsds::MPesa::INS998
            raise InvalidMarketError
          when Paymentsds::MPesa::INS2001
            raise InitiatorAuthenticationError
          when Paymentsds::MPesa::INS2002
            raise InvalidReceiverError
          when Paymentsds::MPesa::INS2051
            raise InvalidMSISDNError
          when Paymentsds::MPesa::INS2057
            raise InvalidLanguageCodeError
          else
            raise UnknownError
          end
          
        when 401
          case result.body[:output_ResponseCode] 
          when Paymentsds::MPesa::INS5
            raise TransactionCancelledError
          when Paymentsds::MPesa::INS6
            raise TransactionFailedError
          else
            raise UnknownError
          end
      
        when 408
          case result.body[:output_ResponseCode] 
          when Paymentsds::MPesa::INS9
            raise RequestTimeoutError
          else
            raise UnknownError
          end

        when 409
          case result.body[:output_ResponseCode] 
          when Paymentsds::MPesa::INS10
            raise DuplicateTransactionError
          else
            raise UnknownError
          end

        when 422
          case result.body[:output_ResponseCode] 
          when Paymentsds::MPesa::INS2006
            raise InsufficientBalanceError
          else
            raise UnknownError
          end

        when 500
          case result.body[:output_ResponseCode] 
          when Paymentsds::MPesa::INS1
            raise InternalError
          else
            raise UnknownError
          end

        when 503
          case result.body[:output_ResponseCode] 
          when Paymentsds::MPesa::INS16
            raise UnavailableServerError
          else
            raise UnknownError
          end

        else
          raise UnknownError
        end        
      end

      def generate_access_token
        @config.generate_access_token
      end
    end
  end
end
