module Paymentsds
    module MPesa
        class Environment
            attr_accessor :scheme
            attr_accessor :domain

            def initialize(scheme, domain) 
                @scheme = scheme
                @domain = domain
            end

            def to_url
                "#{@scheme}://#{@domain}"
            end
        end
    end
end