module Paymentsds
    module MPesa
        class InvalidReceiverError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_RECEIVER)
                super(msg)
            end
        end
    end
end