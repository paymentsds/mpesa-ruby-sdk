module Paymentsds
    module MPesa
        class InvalidMissingPropertiesError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_MISSING_PROPERTIES)
                super(msg)
            end
        end
    end
end