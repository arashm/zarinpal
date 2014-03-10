# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zarinpal/version'

Gem::Specification.new do |spec|
  spec.name          = "zarinpal"
  spec.version       = Zarinpal::VERSION
  spec.authors       = ["Arash Mousavi"]
  spec.email         = ["mousavi.arash@gmail.com"]
  spec.summary       = %q{A gem to to send and verify payments with Zarinpal}
  spec.description   = %q{A gem to to send and verify payments with Zarinpal. Zarinpal is an Iranina provider.}
  spec.homepage      = "http://github.com/arashm/zarinpal"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'savon', ['~> 2.0']

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "listen"
  spec.add_development_dependency "pry-debugger"
end
