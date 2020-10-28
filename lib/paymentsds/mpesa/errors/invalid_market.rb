module Paymentsds
    module MPesa
        class InvalidMarketError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_MARKET)
                super(msg)
            end
        end
    end
end