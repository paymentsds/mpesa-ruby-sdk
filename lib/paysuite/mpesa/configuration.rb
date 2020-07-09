# frozen_string_literal: true

require 'base64'
require 'openssl'

module Paysuite
  module MPesa
    class Configuration
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
        has_access_token = instance_variable_defined?('@access_token')

        @auth = encrypt(@api_key, @public_key) if has_keys
        @auth = @access_token if has_access_token
      end

      private

      def encrypt(api_key, public_key)
        plain_public_key = Base64.decode64 public_key
        key = OpenSSL::PKey::RSA.new plain_public_key
        encrypted_api_key = key.public_encrypt api_key

        Base64.strict_encode64 encrypted_api_key
      end
    end
  end
end
