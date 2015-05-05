# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nyudl/mdi/message/version'

Gem::Specification.new do |spec|
  spec.name          = 'nyudl-mdi-message'
  spec.version       = NYUDL::MDI::Message::VERSION
  spec.authors       = ['jgpawletko']
  spec.email         = ['jgpawletko@gmail.com']
  spec.summary       = 'Message classes for a Message Driven Infrastructure'
  spec.description   = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'validatable'
  spec.add_dependency 'multi_json', '~> 1.10'
  spec.add_dependency 'timeliness'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
