module Paysuite
  module MPesa
    class Operation

      attr_accessor :name
      attr_accessor :method
      attr_accessor :port
      attr_accessor :path
      attr_accessor :mapping
      attr_accessor :requires
      attr_accessor :validation

      def initialize
        yield(self) if block_given?
      end
    end
  end
end
