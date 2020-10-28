module Paymentsds
    module MPesa
        class InactiveAccountError < StandardError
            def initialize(msg=Paymentsds::MPesa::INACTIVE_ACCOUNT)
                super(msg)
            end
        end
    end
end