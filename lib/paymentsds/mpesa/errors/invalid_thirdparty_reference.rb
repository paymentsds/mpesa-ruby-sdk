module Paymentsds
    module MPesa
        class InvalidThirdPartyReferenceError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_THIRDPARTY_REFERENCE)
                super(msg)
            end
        end
    end
end