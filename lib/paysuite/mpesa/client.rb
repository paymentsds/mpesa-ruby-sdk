module Paysuite
  module MPesa
    class Client
      def initialize
        @service = Paysuite::MPesa::Service.new

        yield(@service) if block_given?
      end

      def send(intent)
        @service.handle_send(inent)
      end

      def receive(intent)
        @service.handle_receive(intent)
      end

      def query(intent)
        @service.handle_query(intent)
      end

      def revert(intent)
        @service.handle_revert(intent)
      end
    end
  end
end
