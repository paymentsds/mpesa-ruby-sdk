module Paymentsds
    module MPesa
        class TransactionCancelledError < StandardError
            def initialize(msg=Paymentsds::MPesa::TRANSACTION_CANCELLED)
                super(msg)
            end
        end
    end
end