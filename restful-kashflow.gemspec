lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restful_kashflow/version'

Gem::Specification.new do |spec|
  spec.name          = 'restful_kashflow'
  spec.version       = RestfulKashflow::VERSION
  spec.authors       = %w(Butterware)
  spec.email         = %w(contact@butterware.co.uk)
  spec.summary       = %q{A gem for calling the Kashflow V2 API}
  spec.homepage      = 'https://github.com/butterware/restful-kashflow'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '~> 3.7.0'
  spec.add_development_dependency 'webmock', '~> 1.18'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'
  spec.add_development_dependency 'yard', '~> 0.9.11'

  spec.add_dependency 'rest-client'
end
