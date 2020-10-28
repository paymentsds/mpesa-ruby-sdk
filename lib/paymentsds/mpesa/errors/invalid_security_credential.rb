module Paymentsds
    module MPesa
        class InvalidSecurityCredentialError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_SECURITY_CREDENTIAL)
                super(msg)
            end
        end
    end
end