module Paymentsds
    module MPesa
        class TransactionFailedError < StandardError
            def initialize(msg=Paymentsds::MPesa::TRANSACTION_FAILED)
                super(msg)
            end
        end
    end
end