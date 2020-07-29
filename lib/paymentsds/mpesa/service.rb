# frozen_string_literal: true

module Paymentsds
  module MPesa
    class Service
      attr_accessor :config

      def initialize
        @config = Paymentsds::MPesa::Configuration.new
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
          return Result.new(false, ErrorType::MISSING_PROPERTIES, missing_properties)
        end

        errors = detect_errors(opcode, data)
        unless errors.empty?
          return Result.new(false, ErrorType::VALIDATION_ERROR, errors)
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

          # Should raise an exception
        end

        # Should raise an exception
      end

      def detect_missing_properties(opcode, intent)
        operation = Paymentsds::MPesa::OPERATIONS[opcode]

        operation[:required] - intent.keys
      end

      def detect_errors(opcode, intent)
        operation = Paymentsds::MPesa::OPERATIONS[opcode]

        errors = []

        intent.each do |k, _v|
          errors.push(k) unless (intent[k]).match operation.validation[k]
        end

        errors
      end

      def fill_optional_properties(opcode, intent)
        case opcode
        when :C2B_PAYMENT
          intent[:to] = @config.service_provider_code if intent.key?(:to) && !@config.service_provider_code.nil?
        when :B2B_PAYMENT
          intent[:to] = @config.service_provider_code if intent.key?(:to) && !@config.service_provider_code.nil?
        when :B2C_PAYMENT
          intent[:from] = @config.service_provider_code if intent.key?(:from) && !@config.service_provider_code.nil?
        when :REVERSAL
          intent[:to] = @config.service_provider_code if intent.key?(:to) && !@config.service_provider_code.nil?

          if intent.key?(:initiator_identifier) && !@config.initiator_identifier.nil?
            intent[:initiator_identifier] = @config.initiator_identifier
          end

          if intent.key?(:security_credential) && !@config.security_credential.nil?
            intent[:security_credential] = @config.security_credential
          end
        when :QUERY_TRANSACTION_STATUS
          intent[:to] = @config.service_provider_code if intent.key?(:to) && !@config.service_provider_code.nil?
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
        generate_access_token
        
        request_data = {
          base_url: "#{@config.environment.scheme}://#{@config.environment.domain}:#{operation[:port]}",
          url: operation[:path],
          method: operation[:method],
          path: operation[:path],
          headers: build_request_headers,
          timeout: @config.timeout * 1000,
          body: build_request_body(opcode, intent)
        }

        http_client = Faraday::Connection.new do |client|
          client.url = "#{request_data[:base_url]}/#{request_data[:path]}"
          client.headers = request_data[:headers]
          client.options.timeout = request_data.timeout
        end

        case operation[:method]
        
        when :get
          response = http_client.get do |req|
            req.params = request_data.body
          end

        when :post
          response = http_client.post do |req|
            req.body = request_data.body
          end

        when :put
          response = http_client.put do |req|
            req.body = request_data.body
          end
        end

        bulid_response(response)
      end

      def build_response(result)
        if result.status >= 200 && result.status < 300
          response = Response.new(result.success?, nil, result.data)
        end
        
      end

      def generate_access_token
        @config.generate_access_token
      end
    end
  end
end
