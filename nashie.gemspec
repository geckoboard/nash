# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nash/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["noverloop"]
  gem.email         = ["nicolas@geckoboard.com"]
  gem.description   = %q{Nashie is an extension of Hashie and stands for Nested Hashie. Nashie allows you to create hashes that include other objects}
  gem.summary       = %q{Nashie allows you to create nested Hashie structures}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nashie"
  gem.require_paths = ["lib"]
  gem.version       = Nash::VERSION
end
