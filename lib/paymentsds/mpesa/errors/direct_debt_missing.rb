module Paymentsds
    module MPesa
        class DirectDebtMissingError < StandardError
            def initialize(msg=Paymentsds::MPesa::DIRECT_DEBT)
                super(msg)
            end
        end
    end
end