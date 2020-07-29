module Paymentsds
    module MPesa
        class Result
            attr_reader :error
            attr_reader :data

            def initialize(success, error, data)
                @success = success
                @error = error
                @data = data
            end

            def success?
                @success
            end
        end
    end
end