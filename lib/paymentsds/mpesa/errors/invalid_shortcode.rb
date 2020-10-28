module Paymentsds
    module MPesa
        class InvalidShortcodeError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_SHORTCODE)
                super(msg)
            end
        end
    end
end