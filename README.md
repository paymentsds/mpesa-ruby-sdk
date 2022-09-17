# Ruby M-Pesa SDK


<p align="center"><a href="https://rubygems.org/gems/paymentsds-mpesa/"><img src="https://img.shields.io/gem/dt/paymentsds-mpesa" alt="Total Downloads"></a> <a href="https://rubygems.org/gems/paymentsds-mpesa/"><img src="https://img.shields.io/gem/v/paymentsds-mpesa?include_prereleases" alt="Latest Stable Version"></a> <a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache_2.0-blue.svg" alt="License"></a></p>

This is a library willing to help you to integrate the [Vodacom M-Pesa](https://developer.mpesa.vm.co.mz) operations to your application.

<br>

### Features

Using this library, you can implement the following operations:

- Receive money from a mobile account to a business account (C2B)
- Send money from a business account to a mobile account (B2C)
- Send money from a business account to another business account (B2B)
- Revert any of the transactions above mentioned

<br><br>

## Requirements

- Valid credentials obtained from the [Mpesa Developer](https://developer.mpesa.vm.co.mz) portal
- Port 18352 open on your server (usually open on local env)
- [Ruby 2.5+](https://www.ruby-lang.org)
- [RubyGems](https://rubygems.org)
- [Bundler](https://bundler.io)

<br><br>

### Production Dependencies

- [Faraday](https://github.com/lostisland/faraday)
- [OpenSSL](https://github.com/ruby/openssl)

<br>

### Development Dependencies

- [RSpec](https://github.com/rspec/rspec)
- [Rake](https://github.com/ruby/rake)
- [RuboCop](https://github.com/rubocop-hq/rubocop)
- [Overcommit](https://github.com/sds/overcommit)

<br><br>


## Installation

<br>


### Using RubyGems

```bash
gem install paymentsds-mpesa
```

<br>

### Using Bundler
```ruby
#Gemfile
gem 'paymentsds-mpesa'
```

<br><br>


## Usage

Using this SDK is very simple and fast, let us see some examples:

<br>

#### C2B Transaction (Receive money from mobile account)

```ruby
require 'paymentsds/mpesa'

client = Paymentsds::MPesa::Client.new do |config|
   config.api_key = '<REPLACE>'               # API Key
   config.public_key = '<REPLACE>'            # Public Key
   config.service_provider_code = '<REPLACE>' # input_ServiceProviderCode
end

begin
   payment_data = {
      from: '841234567',       # input_CustomerMSISDN
      reference: '11114',      # input_ThirdPartyReference
      transaction: 'T12344CC', # input_TransactionReference
      amount: '10'             # input_Amount
   }

   result = client.receive(payment_data)

   if result.success?
      puts result.data
   end
rescue
   puts 'Operation failed'
end
```

<br>

#### B2C Transaction (Sending money to mobile account)

```ruby
require 'paymentsds/mpesa'

client = Paymentsds::MPesa::Client.new do |config|
   config.api_key = '<REPLACE>'               # API Key
   config.public_key = '<REPLACE>'            # Public Key
   config.service_provider_code = '<REPLACE>' # input_ServiceProviderCode
end

begin
   payment_data = {
      to: '841234567',       # input_CustomerMSISDN
      reference: '11114',      # input_ThirdPartyReference
      transaction: 'T12344CC', # input_TransactionReference
      amount: '10'             # input_Amount
   }

   result = client.send(payment_data)

   if result.success?
      puts result.data
   end
rescue
   puts 'Operation failed'
end
```

<br>

#### B2B Transaction (Sending money to business account)

```ruby
require 'paymentsds/mpesa'

client = Paymentsds::MPesa::Client.new do |config|
   config.api_key = '<REPLACE>'               # API Key
   config.public_key = '<REPLACE>'            # Public Key
   config.service_provider_code = '<REPLACE>' # input_ServiceProviderCode
end

begin
   payment_data = {
      to: '979797',            # input_ReceiverPartyCode
      reference: '11114',      # input_ThirdPartyReference
      transaction: 'T12344CC', # input_TransactionReference
      amount: '10'             # input_Amount
   }

   result = client.send(payment_data)

   if result.success?
      puts result.data
   end
rescue
   puts 'Operation failed'
end
```

<br>


#### Transaction Reversal

```ruby
require 'paymentsds/mpesa'

client = Paymentsds::MPesa::Client.new do |config|
   config.api_key = '<REPLACE>'               # API Key
   config.public_key = '<REPLACE>'            # Public Key
   config.service_provider_code = '<REPLACE>' # input_ServiceProviderCode
   config.initiator_identifier = '<REPLACE>'  # input_InitiatorIdentifier,
   config.security_identifier = '<REPLACE>'   # input_SecurityCredential
end

begin
   reversion_data = {
      reference: '11114',      # input_ThirdPartyReference
      transaction: 'T12344CC', # input_TransactionReference
      amount: '10'             # input_ReversalAmounts
   }

   result = client.reversion(payment_data)

   if result.success?
      # Handle success scenario
   end
rescue
   # Handle failure scenario
end
```

<br><br>

## Friends

- [M-Pesa SDK for Javascript](https://github.com/paymentsds/mpesa-js-sdk)
- [M-Pesa SDK for Python](https://github.com/paymentsds/mpesa-python-sdk)
- [M-Pesa SDK for Java](https://github.com/paymentsds/mpesa-java-sdk)
- [M-Pesa SDK for PHP](https://github.com/paymentsds/mpesa-php-sdk)


<br><br>

## Authors <a name="authors"></a>

- [Anísio Mandlate](https://github.com/AnisioMandlate)
- [Edson Michaque](https://github.com/edsonmichaque)
- [Elton Laice](https://github.com/eltonlaice)
- [Nélio Macombo](https://github.com/neliomacombo)


<br><br>

## Contributing

Thank you for considering contributing to this package. If you wish to do it, email us at [developers@paymentsds.org](mailto:developers@paymentsds.org) and we will get back to you as soon as possible.


<br><br>

## Security Vulnerabilities

If you discover a security vulnerability, please email us at [developers@paymentsds.org](mailto:developers@paymentsds.org) and we will address the issue with the needed urgency.

<br><br>

## License

Copyright 2022 &copy; The PaymentsDS Team

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
