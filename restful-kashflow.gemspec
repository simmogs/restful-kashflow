lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "restful_kashflow/version"

Gem::Specification.new do |spec|
  spec.name          = "restful_kashflow"
  spec.version       = RestfulKashflow::VERSION
  spec.authors       = %w[Butterware]
  spec.email         = %w[contact@butterware.co.uk]
  spec.summary       = "A gem for calling the Kashflow V2 API"
  spec.homepage      = "https://github.com/butterware/restful-kashflow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "pry"

  spec.add_dependency "rest-client"
end
