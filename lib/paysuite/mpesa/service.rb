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
        handle(intent)
      end

      def handle_revert(intent)
        handle(intent)
      end

      def handle_query(intent)
        handle(intent)
      end

      private

      def handle(operation, intent)
        handle(intent)
      end

      def detect_operation(intent)
      end
    end
  end
end
