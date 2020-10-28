module Paymentsds
    module MPesa
        class InvalidMSISDNError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_MSISDN)
                super(msg)
            end
        end
    end
end