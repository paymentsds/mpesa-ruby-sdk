module Paymentsds
    module MPesa
        class Environment
            attr_accessor :scheme
            attr_accessor :domain

            def initialize(scheme, dommain) 
                @scheme = scheme
                @domain = domain
            end
        end
    end
end