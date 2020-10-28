module Paymentsds
    module MPesa
        class UnknownError < StandardError
            def initialize(msg=Paymentsds::MPesa::UNKNOWN)
                super(msg)
            end
        end
    end
end