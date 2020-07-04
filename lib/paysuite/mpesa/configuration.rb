module Paysuite
  module MPesa
    attr_accessor :access_token
    attr_accessor :api_key
    attr_accessor :public_key
    attr_accessor :user_agent
    attr_accessor :verify_ssl
    attr_accessor :timeout
    attr_accessor :debugging
    attr_accessor :environment
    attr_accessor :initiator_identifier
    attr_accessor :security_credential
    attr_accessor :service_provider_code

    class Configurarion
      def initialize
        yield(self) if block_given?
      end
    end
  end
end
