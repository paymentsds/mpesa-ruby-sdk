module Paysuite
  module MPesa
    class Service
      attr_accessor :config

      def initialize
        @http_client = :client
        @config = Configuration
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

      def handle_query(intent)
        handle_request(:QUERY_TRANSACTION_STATUS, ntent)
      end

      private

      def handle_request(operation, intent)
        data = fill_optional_properties(operation, intent)

        missing_properties = detect_missing_properties(operation, data)
        return missing_properties if missing_properties.size == 0

        errors = detect_errors(operation, data)
        return errors if errors.size == 0

        return perform_request(opcode, intent)
      end

      def detect_operation(intent)
        if intent.has_key? :to
          case data[:to]
          when /^((00|\+)?258)?8[45][0-9]{7}$/
            :C2B_PAYMENT
          when /^[0-9]{5,6}$/
            :B2B_PAYMENT
          end

          # Should raise an exception
        end

        # Should raise an exception
      end

      def detect_missing_properties(code, intent)
        operation = OPERATIONS[code]
        missing = operation.requires - intent.keys
      end

      def detect_errors(code, intent)
        operation = OPERATIONS[code]

        errors = []
        for key in intent.keys
          errors.push(key) unless (intent[key]).match operation.mapping[key]
        end

        return errors
      end

      def fill_optional_properties(opcode, intent)
        operation = OPERATION[opcode]

        case opcode
        when :C2B_PAYMENT
          if intent.has_key? :to and @config.service_provider_code != nil
            intent[:to] = @config.service_provider_code
          end
        when :B2B_PAYMENT
          if intent.has_key? :to and @config.service_provider_code != nil
            intent[:to] = @config.service_provider_code
          end
        when :B2C_PAYMENT
          if intent.has_key? :from and @config.service_provider_code != nil
            intent[:from] = @config.service_provider_code
          end
        when :REVERSAL
          if intent.has_key? :to and @config.service_provider_code != nil
            intent[:to] = @config.service_provider_code
          end

          if intent.has_key? :initiator_identifier and @config.initiator_identifier != nil
            intent[:initiator_identifier] = @config.initiator_identifier
          end

          if intent.has_key? :security_credential and @config.security_credential != nil
            intent[:security_credential] = @config.security_credential
          end
        when :QUERY_TRANSACTION_STATUS
          if intent.has_key? :to and @config.service_provider_code != nil
            intent[:to] = @config.service_provider_code
          end
        end

        return intent
      end

      def build_request_body
        
      end

      def build_request_headers
        generate_access_token

        headers = {
          :'Authorization' => 'Bearer ' + @config.auth,
          :'Origin' => @config.origin,
          :'Content-Type' => 'application/json',
          :'User-Agent' => @config.user_agent
        }

        return headers
      end

      def perform_request(opcode, intent)
        body = build_request_body(opcode, intent)
        headers = build_request_headers(opcode, intent)
      end

      def generate_access_token
        @config.generate_access_token
      end
    end
  end
end
