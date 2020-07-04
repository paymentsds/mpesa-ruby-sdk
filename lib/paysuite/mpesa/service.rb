module Paysuite
  module MPesa
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
    end
  end
end
