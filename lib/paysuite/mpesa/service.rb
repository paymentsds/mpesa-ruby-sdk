module Paysuite
  module MPesa
    OPERATIONS = {
      :C2B_PAYMENT => 
      Paysuite::MPesa::Operation.new do |operation|
        operation.method = 'post'
        operation.port = ''
        operation.path = ''
        operation.mapping = {
          to: '',
          from: '',
          amount: '',
          reference: '',
          transaction: ''
        }
        operation.validation = {
          to: '',
          from: '',
          amount: '',
          reference: '',
          transaction: ''
        }
        operation.required = [
        ]
        operation.optional = [
        ]
      end

      :B2C_PAYMENT =>
      :B2B_PAYMENT => 
      :REVERSAL =>
      :QUERY_TRANSACTION_STATUS =>
    }

    class Service
      def initialize
      end

      def handle_send(intent)
        operation = detect_operation(intent)
        handle(operation, intent)
      end

      def handle_receive(intent)
        handle(:C2B_PAYMENT, intent)
      end

      def handle_revert(intent)
        handle(:REVERSAL, intent)
      end

      def handle_query(:QUERY_TRANSACTION_STATUS, intent)
        handle(intent)
      end

      private

      def handle(operation, intent)
        data = fill_optional_properties(operation, intent)

        missing_properties = detect_missing_properties(operation, data)
        return missing_properties if missing_properties.size == 0

        errors = detect_errors(operation, data)
        return errors if errors.size == 0

        puts(operation)
        puts(intent)
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
        missing = operation.required - intent.keys

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
    end
  end
end
