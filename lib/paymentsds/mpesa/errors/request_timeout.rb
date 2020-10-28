module Paymentsds
    module MPesa
        class ProfileProblemsError < StandardError
            def initialize(msg=Paymentsds::MPesa::PROFILE_PROBLEMS)
                super(msg)
            end
        end
    end
end