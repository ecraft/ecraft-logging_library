# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logging_library/version'

Gem::Specification.new do |spec|
  spec.name          = 'logging_library'
  spec.version       = LoggingLibrary::VERSION
  spec.authors       = ['Tre Kronor']
  spec.email         = ['team.trekronor@ecraft.com']

  spec.summary       = 'Logging library'
  spec.description   = 'Library with support for logging in applications.'
  spec.homepage      = 'https://github.com/ecraft/logging_library'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mixlib-log', '~> 1.7'
  spec.add_runtime_dependency 'rainbow', '~> 2.2'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.5'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.50', '< 0.51'
  spec.add_development_dependency 'yard', '~> 0.9'
end
