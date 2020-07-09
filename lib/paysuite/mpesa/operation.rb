# frozen_string_literal: true

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
      attr_accessor :optional

      def initialize
        yield(self) if block_given?
      end
    end
  end
end
