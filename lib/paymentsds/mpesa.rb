# frozen_string_literal: true

require_relative 'mpesa/version'
require_relative 'mpesa/operation'
require_relative 'mpesa/constants'
require_relative 'mpesa/environment'
require_relative 'mpesa/configuration'
require_relative 'mpesa/result'
require_relative 'mpesa/error_type'
require_relative 'mpesa/service'
require_relative 'mpesa/client'

module Paymentsds
  module MPesa
    class Error < StandardError; end
  end
end
