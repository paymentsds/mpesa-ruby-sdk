module Paymentsds
    module MPesa
        class ValidationError < StandardError
            def initialize(msg=Paymentsds::MPesa::VALIDATION)
                super(msg)
            end
        end
    end
end