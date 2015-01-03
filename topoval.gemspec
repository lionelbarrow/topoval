# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'topoval/version'

Gem::Specification.new do |spec|
  spec.name          = "topoval"
  spec.version       = Topoval::VERSION
  spec.authors       = ["lionelbarrow"]
  spec.email         = ["lionelbarrow@gmail.com"]
  spec.description   = "A library for executing validation in a specific order."
  spec.summary       = "A library for executing validation in a specific order."
  spec.homepage      = "https://github.com/lionelbarrow/topoval"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rgl", "~> 0.5.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 3.1.0"
end
