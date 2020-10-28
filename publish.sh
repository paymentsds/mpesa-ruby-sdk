#!/bin/env bash

rm -rf *.gem
gem build paymentsds-mpesa.gemspec
gem push *.gem
gem install paymentsds-mpesa --pre
