# frozen_string_literal: true

module Paymentsds
  module MPesa
    PATTERNS = {
      PHONE_NUMBER: /^((00|\+)?(258))?8[45][0-9]{7}$/,
      MONEY_AMOUNT: /^[1-9][0-9]*(\.[0-9]+)?$/,
      WORD: /^\w+$/,
      SERVICE_PROVIDER: /^[0-9]{5,6}$/
    }.freeze

    OPERATIONS = {
      C2B_PAYMENT: {
        method: :post,
        port: '18352',
        path: '/ipg/v1x/c2bPayment/singleStage/',
        mapping: {
          to: 'input_ServiceProviderCode',
          from: 'input_CustomerMSISDN',
          amount: 'input_Amount',
          reference: 'input_ThirdPartyReference',
          transaction: 'input_TransactionReference'
        },
        validation: {
          to: PATTERNS[:SERVICE_PROVIDER],
          from: PATTERNS[:PHONE_NUMBER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD]
        },
        required: [
          :to,
          :from,
          :amount,
          :reference,
          :transaction
        ],
        optional: [
          :to
        ]
      },

      B2C_PAYMENT: {
        method: :post,
        port: '18345',
        path: '/ipg/v1x/b2cPayment/',
        mapping: {
          to: 'input_ServiceProviderCode',
          from: 'input_CustomerMSISDN',
          amount: 'input_Amount',
          reference: 'input_ThirdPartyReference',
          transaction: 'input_TransactionReference'
        },
        validation: {
          to: PATTERNS[:SERVICE_PROVIDER],
          from: PATTERNS[:PHONE_NUMBER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD]
        },
        required: [
          :to,
          :from,
          :amount,
          :reference,
          :transaction
        ],
        optional: [
          :to
        ]
      },

      B2B_PAYMENT: {
        method: :post,
        port: '18349',
        path: '/ipg/v1x/b2bPayment/',
        mapping: {
          to: 'input_ServiceProviderCode',
          from: 'input_CustomerMSISDN',
          amount: 'input_Amount',
          reference: 'input_ThirdPartyReference',
          transaction: 'input_TransactionReference'
        },
        validation: {
          to: PATTERNS[:SERVICE_PROVIDER],
          from: PATTERNS[:PHONE_NUMBER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD]
        },
        required: [
          :to,
          :from,
          :amount,
          :reference,
          :transaction
        ],
        optional: [
          :to
        ]
      },

      REVERSAL: {
        method: :put,
        port: '18354',
        path: '/ipg/v1x/reversal/',
        mapping: {
          to: 'input_ServiceProviderCode',
          from: 'input_CustomerMSISDN',
          amount: 'input_Amount',
          reference: 'input_ThirdPartyReference',
          transaction: 'input_TransactionReference'
        },
        validation: {
          to: PATTERNS[:SERVICE_PROVIDER],
          from: PATTERNS[:PHONE_NUMBER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD]
        },
        required: [
          :to,
          :from,
          :amount,
          :reference,
          :transaction
        ],
        optional: [
          :to
        ]
      },

      QUERY_TRANSACTION_STATUS: {
        method: :get,
        port: '18353',
        path: '/ipg/v1x/queryTransactionStatus/',
        mapping: {
          to: 'input_ServiceProviderCode',
          from: 'input_CustomerMSISDN',
          amount: 'input_Amount',
          reference: 'input_ThirdPartyReference',
          transaction: 'input_TransactionReference'
        },
        validation: {
          to: PATTERNS[:SERVICE_PROVIDER],
          from: PATTERNS[:PHONE_NUMBER],
          amount: PATTERNS[:MONEY_AMOUNT],
          reference: PATTERNS[:WORD],
          transaction: PATTERNS[:WORD]
        },
        required: [
          :to,
          :from,
          :amount,
          :reference,
          :transaction
        ],
        optional: [
          :to
        ]
      }
    }.freeze
  end
end
