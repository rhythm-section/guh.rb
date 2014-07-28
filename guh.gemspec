# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guh/version'

Gem::Specification.new do |spec|
  spec.name          = "guh"
  spec.version       = Guh::VERSION
  spec.authors       = ["Christoph Edthofer", "Thomas Esterer"]
  spec.email         = ["christoph.edthofer@guh.guru", "thomas.esterer@guh.guru"]
  spec.summary       = %q{The official Ruby wrapper for guh.}
  spec.description   = "The official Ruby wrapper for guh. guh is an open source home automation system."
  spec.homepage      = "http://guh.guru"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 1.8"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake",    "~> 10.3"
  spec.add_development_dependency "rspec",   "~> 2.14"
  spec.add_development_dependency "yard",    "~> 0.8"
end
