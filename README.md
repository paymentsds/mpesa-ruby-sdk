# M-Pesa SDK for Ruby

M-Pesa SDK for Ruby is an unofficial library aiming to help businesses integrating every [M-Pesa](https://developer.mpesa.vm.co.mz) operations to their Ruby applications.

## Contents

1. [Features](#features)
1. [Usage](#usage)
   1. [Quickstart](#usage/scenario-1)
   1. [Receive Money from a Mobile Account](#usage/scenario-1)
   1. [Send Money to a Mobile Account](#usage/scenario-2)
   1. [Send Money to a Business Account](#usage/scenario-3)
   1. [Revert a Transaction](#usage/scenario-4)
   1. [Query the Status of a Transaction](#usage/scenario-5)
   1. [Examples](#usage/scenario-6)
1. [Prerequisites](#prerequisites)
1. [Installation](#installation)
   1. [Using RubyGems](#installation/scenario-1)
   1. [Using Bundler](#installation/scenario-2)
   1. [Installation Scenario 3](#installation/scenario-3)
   1. [Installation Scenario 4](#installation/scenario-4)
1. [Configuration](#configuration)
   1. [Configuration Scenario 1](#configuration/scenario-1)
   1. [Configuration Scenario 2](#configuration/scenario-2)
   1. [Configuration Scenario 3](#configuration/scenario-3)
   1. [Configuration Scenario 4](#configuration/scenario-4)
1. [Related Projects](#related-projects)
   1. [Dependencies](#related-projects/dependencies)
   1. [Friends](#related-projects/friends)
   1. [Alternatives](#related-projects/alternatives)
1. [Contributing](#contributing)
1. [Changelog](#changelog)
1. [Authors](#authors)
1. [Credits](#credits)
1. [License](#license)

## Features <a name="features"></a>

- Receive money from a mobile account to a business account
- Send money from a business account to a mobile account
- Send money from a business account to a another business account
- Revert a transaction
- Query the status of a transaction

## Usage <a name="usage"></a>

### Quickstart <a name="#usage/scenario-1"></a>

### Receive Money from a Mobile Account <a name="#usage/scenario-2"></a>

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
### Send Money to a Mobile Account <a name="#usage/scenario-3"></a>

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

### Send Money to a Business Account <a name="#usage/scenario-4"></a>

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

### Revert a Transaction <a name="#usage/scenario-5"></a>

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

### Query the Status of a Transaction <a name="#usage/scenario-6"></a>

### Examples <a name="usage/scenario-7"></a>

## Prerequisites <a name="prerequisites"></a>

- [Ruby 2.5+](https://www.ruby-lang.org)
- [RubyGems](https://rubygems.org)
- [Bundler](https://bundler.io)

## Installation <a name="installation"></a>

### Using RubyGems <a name="installation/scenario-1"></a>

```bash
gem install paymentsds-mpesa
```

### Using Bundler <a name="installation/scenario-2"></a>

```ruby
#Gemfile
gem 'paymentsds-mpesa'
```

### Installation Scenario 3 <a name="installation/scenario-3"></a>

## Configuration <a name="configuration"></a>

### Configuration Scenario 1 <a name="configuration/scenario-1"></a>

### Configuration Scenario 2 <a name="configuration/scenario-2"></a>

### Configuration Scenario 3 <a name="configuration/scenario-3"></a>

## Related Projects <a name="related-projects"></a>

### Dependencies <a name="related-projects/dependencies"></a>

#### Production Dependencies

- [Faraday](https://github.com/lostisland/faraday)

#### Development Dependencies

- [RSpec](https://github.com/rspec/rspec)
- [Rake](https://github.com/ruby/rake)

### Friends <a name="related-projects/friends"></a>

- [M-Pesa SDK for Javascript](https://github.com/paymentsds/mpesa-js-sdk)
- [M-Pesa SDK for PHP](https://github.com/paymentsds/mpesa-php-sdk)
- [M-Pesa SDK for Ruby](https://github.com/paymentsds/mpesa-ruby-sdk)
- [M-Pesa SDK for Python](https://github.com/paymentsds/mpesa-python-sdk)

### Alternatives <a name="related-projects/alternatives"></a>

- [Alternative 1](https://github.com/<username>/<project>)
- [Alternative 2](https://github.com/<username>/<project>)
- [Alternative 3](https://github.com/<username>/<project>)
- [Alternative 4](https://github.com/<username>/<project>)


### Inspiration

- [rosariopfernandes/mpesa-node-api](https://github.com/abdulmueid/mpesa-php-api)
- [karson/mpesa-php-sdk](https://github.com/karson/mpesa-php-sdk)
- [codeonweekends/mpesa-php-sdk](https://github.com/codeonweekends/mpesa-php-sdk)
- [abdulmueid/mpesa-php-api](https://github.com/abdulmueid/mpesa-php-api)
- [realdm/mpesasdk](https://github.com/realdm/mpesasdk)


## Contributing <a name="contributing"></a>

## Changelog <a name="changelog"></a>

## Authors <a name="authors"></a>

- [Edson Michaque](https://github.com/edsonmichaque)
- [Nélio Macombo](https://github.com/neliomacombo)

## Credits <a name="credits"></a>

## License <a name="license"></a>

Copyright 2020 Edson Michaque and Nélio Macombo

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

