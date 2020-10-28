module Paymentsds
    module MPesa
        class InsuficientBalanceError < StandardError
            def initialize(msg=Paymentsds::MPesa::INSUFICIENT_BALANCE)
                super(msg)
            end
        end
    end
end