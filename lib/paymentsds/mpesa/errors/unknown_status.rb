module Paymentsds
    module MPesa
        class UnknownStatusError < StandardError
            def initialize(msg=Paymentsds::MPesa::UNKNOWN_STATUS)
                super(msg)
            end
        end
    end
end