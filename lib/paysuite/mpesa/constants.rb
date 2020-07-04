module Paysuite
  module MPesa
    PATTERNS = {
      :PHONE_NUMBER => /^((00|\+)?(258))?8[45][0-9]{7}$/,
      :MONEY_AMOUNT => /^[1-9][0-9]*(\.[0-9]+)?$/,
      :WORD => /^\w+$/,
      :SERVICE_PROVIDEER => /^[0-9]{5,6}$/,
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
          to: PATTERNS[:SERVICE_PROVIDEER],
          from: PATTERNS[:PHONE_NUMBER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD],
        }
        operation.requires = [
          "to",
          "from",
          "amount",
          "reference",
          "transaction",
        ]
        operation.optional = [
          "to",
        ]
      end,

      :B2C_PAYMENT => Operation.new do |operation|
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
          to: "",
          from: "",
          amount: "",
          reference: "",
          transaction: "",
        }
        operation.requires = [
          "to",
          "from",
          "amount",
          "reference",
          "transaction",
        ]
        operation.optional = [
          "to",
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
          to: "",
          from: "",
          amount: "",
          reference: "",
          transaction: "",
        }
        operation.requires = [
          "to",
          "from",
          "amount",
          "reference",
          "transaction",
        ]
        operation.optional = [
          "to",
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
          to: "",
          from: "",
          amount: "",
          reference: "",
          transaction: "",
        }
        operation.requires = [
          "to",
          "from",
          "amount",
          "reference",
          "transaction",
        ]
        operation.optional = [
          "to",
        ]
      end,

      :QUERY_TRANSACTION_STATUS => Operation.new do |operation|
        operation.method = "GET"
        operation.port = "18353"
        operation.path = "/ipg/v1x/queryTransactionStatus"
        operation.mapping = {
          reference: "input_QueryReference",
          conversation: "input_QueryReference",
          transaction: "input_QueryReference",
          from: "input_ServiceProviderCode",
          application: "input_ThirdPartyReference",
        }
        operation.validation = {
          to: "",
          from: "",
          amount: "",
          reference: "",
          transaction: "",
        }
        operation.requires = [
          "to",
          "from",
          "amount",
          "reference",
          "transaction",
        ]
        operation.optional = [
          "to",
        ]
      end,
    }
  end
end
