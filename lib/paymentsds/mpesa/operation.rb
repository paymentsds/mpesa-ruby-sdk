# frozen_string_literal: true

module Paymentsds
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

      def valid?
        method_valid = ['get', 'post'].include? @method
        port_valid = @port.to_s.match? /^[0-9]{1,5}$/
        requires_is_array = @requires.is_a? Array

        method_valid && port_valid && requires_is_array
      end
    end
  end
end
