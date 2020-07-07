module Paysuite
  module MPesa
    PATTERNS = {
      :PHONE_NUMBER => /^((00|\+)?(258))?8[45][0-9]{7}$/,
      :MONEY_AMOUNT => /^[1-9][0-9]*(\.[0-9]+)?$/,
      :WORD => /^\w+$/,
      :SERVICE_PROVIDER => /^[0-9]{5,6}$/,
    }
    
    OPERATIONS = {
      :C2B_PAYMENT => Operation.new do |operation|
        operation.method = "POST"
        operation.port = "18352"
        operation.path = "/ipg/v1x/c2bPayment/singleStage"
        operation.mapping = {
          to: "input_ServiceProviderCode",
          from: "input_CustomerMSISDN",
          amount: "input_Amount",
          reference: "input_ThirdPartyReference",
          transaction: "input_TransactionReference",
        }
        operation.validation = {
          to: PATTERNS[:SERVICE_PROVIDER],
          from: PATTERNS[:PHONE_NUMBER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD],
        }
        operation.requires = [
          :to,
          :from,
          :amount,
          :reference,
          :transaction,
        ]
        operation.optional = [
          :to,
        ]
      end,

      :B2C_PAYMENT => Operation.new do |operation|
        operation.method = "POST"
        operation.port = "18352"
        operation.path = "/ipg/v1x/c2bPayment/singleStage"
        operation.mapping = {
          to: "input_CustomerMSISDN",
          from: "input_ServiceProviderCode",
          amount: "input_Amount",
          reference: "input_ThirdPartyReference",
          transaction: "input_TransactionReference",
        }
        operation.validation = {
          to: PATTERNS[:PHONE_NUMBER],
          from: PATTERNS[:SERVICE_PROVIDER],
          amount:  PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD],
        }
        operation.requires = [
          :to,
          :from,
          :amount,
          :reference,
          :transaction,
        ]
        operation.optional = [
          :from,
        ]
      end,

      :B2B_PAYMENT => Operation.new do |operation|
        operation.method = "POST"
        operation.port = "18352"
        operation.path = "/ipg/v1x/c2bPayment/singleStage"
        operation.mapping = {
          to: "input_ServiceProviderCode",
          from: "input_CustomerMSISDN",
          amount: "input_Amount",
          reference: "input_ThirdPartyReference",
          transaction: "input_TransactionReference",
        }
        operation.validation = {
          to: PATTERNS[:SERVICE_PROVIDER],
          from: PATTERNS[:SERVICE_PROVIDER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD],
        }
        operation.requires = [
          :to,
          :from,
          :amount,
          :reference,
          :transaction,
        ]
        operation.optional = [
          :from,
        ]
      end,

      :REVERSAL => Operation.new do |operation|
        operation.method = "POST"
        operation.port = "18352"
        operation.path = "/ipg/v1x/c2bPayment/singleStage"
        operation.mapping = {
          to: "input_ServiceProviderCode",
          from: "input_CustomerMSISDN",
          amount: "input_Amount",
          reference: "input_ThirdPartyReference",
          transaction: "input_TransactionReference",
        }
        operation.validation = {
          to: PATTERNS[:SERVICE_PROVIDER],
          from: PATTERNS[:SERVICE_PROVIDER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD],
          initiator_identifier: PATTERNS[:SERVICE_PROVIDER],
          security_credential: PATTERNS[:WORD]
        }
        operation.requires = [
          :to,
          :from,
          :amount,
          :reference,
          :transaction,
        ]
        operation.optional = [
          :to,
        ]
      end,

      :QUERY_TRANSACTION_STATUS => Operation.new do |operation|
        operation.method = "GET"
        operation.port = "18353"
        operation.path = "/ipg/v1x/queryTransactionStatus"
        operation.mapping = {
          query: "input_QueryReference",
          from: "input_ServiceProviderCode",
          reference: "input_ThirdPartyReference",
        }
        operation.validation = {
          query: PATTERNS[:WORD],
          reference: PATTERNS[:WORD],
          from: PATTERNS[:SERVICE_PROVIDER]
        }
        operation.requires = [
          :query,
          :reference,
          :from,
        ]
        operation.optional = [
          :from,
        ]
      end,
    }
  end
end
