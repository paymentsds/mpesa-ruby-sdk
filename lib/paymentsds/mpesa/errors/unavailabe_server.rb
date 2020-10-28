module Paymentsds
    module MPesa
        class UnavailableServerError < StandardError
            def initialize(msg=Paymentsds::MPesa::UNAVAILABLE_SERVER)
                super(msg)
            end
        end
    end
end