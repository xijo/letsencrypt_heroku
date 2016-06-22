# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'letsencrypt_heroku/version'

Gem::Specification.new do |spec|
  spec.name          = 'letsencrypt_heroku'
  spec.version       = LetsencryptHeroku::VERSION
  spec.authors       = ['Johannes Opper']
  spec.email         = ['johannes.opper@gmail.com']

  spec.summary       = %q{Setup SSL for heroku with letsencrypt}
  spec.description   = %q{Setup SSL for heroku with letsencrypt}
  spec.homepage      = 'https://github.com/xijo/letsencrypt_heroku'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.require_paths = ["lib"]
  spec.executables   << 'letsencrypt_heroku'

  spec.add_dependency "rainbow"
  spec.add_dependency "acme-client"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
