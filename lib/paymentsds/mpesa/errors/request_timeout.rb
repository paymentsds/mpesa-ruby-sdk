module Paymentsds
    module MPesa
        class RequestTimeoutError < StandardError
            def initialize(msg=Paymentsds::MPesa::REQUEST_TIMEOUT)
                super(msg)
            end
        end
    end
end