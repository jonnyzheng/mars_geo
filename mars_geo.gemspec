# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mars_geo/version'

Gem::Specification.new do |gem|
  gem.name          = "mars_geo"
  gem.version       = MarsGeo::VERSION
  gem.authors       = ["Jonny"]
  gem.email         = ["mars131@gmail.com"]
  gem.description   = %q{Mars geograpic lib}
  gem.summary       = %q{Implementation of china geograpic encrypt which offset the position for display correctly in chinese map service }
  gem.homepage      = "https://github.com/jonnyzheng/mars_geo"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
