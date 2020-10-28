module Paymentsds
    module MPesa
        class InvalidInitiatorIdentifierError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_INITIATOR_IDENTIFIER)
                super(msg)
            end
        end
    end
end