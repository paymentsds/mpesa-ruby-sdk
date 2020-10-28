module Paymentsds
    module MPesa
        class InitiatorAuthenticationError < StandardError
            def initialize(msg=Paymentsds::MPesa::INITIATOR_AUTHENTICATION)
                super(msg)
            end
        end
    end
end