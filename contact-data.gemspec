lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'contact-data/version'

Gem::Specification.new do |spec|
  spec.name = 'contact-data'
  spec.version = ContactData::VERSION
  spec.authors = ['Xenapto']
  spec.email = ['developers@xenapto.com']
  spec.description = 'A Ruby gem to retrieve data about people and organizations from http://public.xenapto.com'
  spec.summary = "Example: ContactData.search('John Smith III')"
  spec.homepage = 'https://github.com/Xenapto/contact-data'
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($RS)
  spec.executables = spec.files.grep(%r{^bin\/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features|coverage)\/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rest-client', '~> 1'
  spec.add_runtime_dependency 'addressable', '~> 2.3'

  spec.add_development_dependency 'rake', '~> 11'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'gem-release', '~> 0.7'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'byebug', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 0.31'
  spec.add_development_dependency 'listen', '~> 3.0', '< 3.1' # Dependency of guard, 3.1 requires Ruby 2.2+
  spec.add_development_dependency 'guard', '~> 2.12'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
end
