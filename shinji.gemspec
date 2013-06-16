# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shinji/version"

Gem::Specification.new do |spec|
  spec.name          = "shinji"
  spec.version       = Shinji::VERSION
  spec.authors       = ["Alex Smith"]
  spec.email         = ["alex@thatalexguy.com"]
  spec.description   = "Client gem for Gendo"
  spec.summary       = "Client gem for Gendo"
  spec.homepage      = "https://github.com/ags/shinji"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 3.0"
  spec.add_dependency "request_store", "~> 1.0.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", ">= 0.9.2"
  spec.add_development_dependency "rspec", "~> 2.12"
  spec.add_development_dependency "rspec-rails", "~> 2.12"
  spec.add_development_dependency "webmock", "~> 1.11.0"
end
