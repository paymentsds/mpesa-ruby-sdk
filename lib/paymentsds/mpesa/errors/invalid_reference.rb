module Paymentsds
    module MPesa
        class InvalidReferenceError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_REFERENCE)
                super(msg)
            end
        end
    end
end