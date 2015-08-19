# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marinetraffic/version'

Gem::Specification.new do |spec|
  spec.name          = "marinetraffic"
  spec.version       = Marinetraffic::VERSION
  spec.authors       = ["Fabio Kuhn"]
  spec.email         = ["mordaroso@gmail.com"]

  spec.summary       = %q{Ruby API wrapper for http://marinetraffic.com}
  spec.description   = %q{This is a API wrapper for MarineTraffic written in Ruby. You can find more information about the API of MarineTraffic on this page: https://www.marinetraffic.com/en/ais-api-services}
  spec.homepage      = "https://github.com/mordaroso/marinetraffic."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", ">= 1.7.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest", "~> 2.4.4"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
