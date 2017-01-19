# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ecraft/logging_library/version'

Gem::Specification.new do |spec|
  spec.name          = 'ecraft-logging_library'
  spec.version       = Ecraft::LoggingLibrary::VERSION
  spec.authors       = ['Tre Kronor']
  spec.email         = ['team.trekronor@ecraft.com']

  spec.summary       = 'eCraft logging library'
  spec.description   = 'Library with support for logging in applications.'
  spec.homepage      = 'https://github.com/ecraft/ecraft-logging_library'
  spec.license       = 'Nonstandard'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = 'https://push.fury.io'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mixlib-log'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.5'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.46'
  spec.add_development_dependency 'yard', '~> 0.9'
end
