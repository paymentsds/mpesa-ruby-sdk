module Paysuite
  module MPesa
    class Configurarion
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
      attr_accessor :origin
      attr_reader :auth
      
      def initialize
        yield(self) if block_given?
      end

      def generate_access_token
         has_keys = instance_variable_defined?('@api_key') and instance_variable_defined?('@public_key')
         has_access_token = instance_valriable_defined?('@access_token')
         
         @auth = @api_key + @public_key if has_keys           
         @auth = @access_token if has_access_token 
      end
    end
  end
end
