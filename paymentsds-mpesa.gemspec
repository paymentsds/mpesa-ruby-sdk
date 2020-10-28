require_relative 'lib/paymentsds/mpesa/version'

Gem::Specification.new do |spec|
  spec.name          = 'paymentsds-mpesa'
  spec.version       = Paymentsds::MPesa::VERSION
  spec.authors       = ['Edson Michaque']
  spec.email         = ['edson@michaque.com']

  spec.summary       = 'A Ruby library aiming to helps developers integrating their products with M-Pesa Platform'
  spec.description   = %q{M-Pesa SDK for Ruby is an unofficial library aiming to help businesses integrating every M-Pesa operations to their Ruby applications.}
  spec.homepage      = "https://github.com/paymentsds/mpesa-ruby-sdk"
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
  spec.license       = 'Apache-2.0'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'faraday', '~> 1.0.1', '>= 1.0.1'
  spec.add_development_dependency 'rspec', '~> 3.9.0', '>= 3.9.0'
  spec.add_development_dependency 'overcommit', '~> 0.55.0', '>= 0.55.0'
  spec.add_development_dependency 'rubocop', '~> 0.88.0', '>= 0.88.0'
  spec.add_development_dependency 'faraday_middleware'
end
