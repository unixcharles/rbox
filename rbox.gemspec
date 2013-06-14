# encoding: utf-8

Gem::Specification.new do |gem|
  gem.add_dependency 'faraday', '>= 0.7'
  gem.add_dependency 'faraday_middleware', '>= 0.7'
  gem.add_dependency 'multi_xml', '~> 0.4.1'

  gem.authors = ["Charles Barbier"]
  gem.description = %q{A Ruby wrapper for box.com}
  gem.email = ['unixcharles@gmail.com']
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/unixcharles/rbox'
  gem.name = 'rbox'
  gem.require_paths = ['lib']
  gem.summary = %q{box.com API wrapper}
  gem.test_files = `git ls-files -- {spec}/*`.split("\n")
  gem.version = '0.1.3'
end
