# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ecreporter/version'

Gem::Specification.new do |spec|
  spec.name          = "ecreporter"
  spec.version       = ECReporter::VERSION
  spec.authors       = ["Iori Mizutani"]
  spec.email         = ["iori.mizutani@gmail.com"]
  spec.homepage      = "https://github.com/iomz/ecreporter"
  spec.summary       = %q{ECReport Viewer web application}
  spec.description   = %q{}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "foreman"

  spec.add_dependency "awesome_print"
  spec.add_dependency "faye-websocket"
  spec.add_dependency "haml"
  spec.add_dependency "json"
  spec.add_dependency "naturally"
  spec.add_dependency "nokogiri"
  spec.add_dependency "puma"
  spec.add_dependency "sinatra"
  spec.add_dependency "sinatra-activerecord"

  spec.required_ruby_version = ">= 2.0.0"
end
