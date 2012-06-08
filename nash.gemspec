# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nash/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["noverloop"]
  gem.email         = ["nicolas@geckoboard.com"]
  gem.description   = %q{Nash stands for Nested Dash allows you to create hashes that include other objects}
  gem.summary       = %q{Nested Dash allows you to create nested Dash structures so you can validate complex json objects}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nash"
  gem.require_paths = ["lib"]
  gem.version       = Nash::VERSION
end
