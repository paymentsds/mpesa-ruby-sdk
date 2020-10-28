module Paymentsds
    module MPesa
        class TransactionIdError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_TRANSACTION_ID)
                super(msg)
            end
        end
    end
end