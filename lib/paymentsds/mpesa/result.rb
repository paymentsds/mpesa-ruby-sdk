module Paymentsds
    module MPesa
        class Result
            attr_accessor :response
            attr_accessor :transaction_id
            attr_accessor :conversation_id
            attr_accessor :reference

            def initialize
                yield(self) if block_given?
            end
        end
    end
end