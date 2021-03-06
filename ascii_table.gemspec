# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ascii_table/version'

Gem::Specification.new do |spec|
  spec.name          = "ascii_table"
  spec.version       = AsciiTable::VERSION
  spec.authors       = ["Peter Suschlik"]
  spec.email         = ["ps@neopoly.de"]
  spec.summary       = %q{Create ascii table from command line}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/neopoly/ascii_table"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "terminal-table", "~> 1.4"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "maxitest"
end
