# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple-server/version'

Gem::Specification.new do |gem|
  gem.name          = "simple-server"
  gem.version       = SimpleServer::VERSION
  gem.authors       = ["Łukasz Dubiel"]
  gem.email         = ["bambucha14@gmail.com"]
  gem.description   = "Simple server for operation system subject"
  gem.summary       = "Only for get good raiting on university"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
