module Paymentsds
    module MPesa
        class InvalidTransactionReferenceError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_TRANSACTION_REFERENCE)
                super(msg)
            end
        end
    end
end