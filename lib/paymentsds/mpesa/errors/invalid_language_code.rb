module Paymentsds
    module MPesa
        class InvalidLanguageCodeError < StandardError
            def initialize(msg=Paymentsds::MPesa::INVALID_LANGUAGE_CODE)
                super(msg)
            end
        end
    end
end