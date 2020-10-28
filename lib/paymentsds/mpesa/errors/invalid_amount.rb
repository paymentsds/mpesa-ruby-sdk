module Paymentsds
    module MPesa
        class InvalidAmountError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_AMOUNT)
                super(msg)
            end
        end
    end
end