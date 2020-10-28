module Paymentsds
    module MPesa
        class DuplicateDirectDebtError < StandardError
            def initialize(msg=Paymentsds::MPesa::DUPLICATE_TRANSACTION)
                super(msg)
            end
        end
    end
end