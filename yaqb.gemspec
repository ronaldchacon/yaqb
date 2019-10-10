lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yaqb/version"

Gem::Specification.new do |spec|
  spec.name          = "yaqb"
  spec.version       = Yaqb::VERSION
  spec.authors       = ['Ronald Chacon']
  spec.email         = ['ronald.chacon87@gmail.com']

  spec.summary       = 'YAQB'
  spec.description   = 'Yet Another Query Builder'
  spec.homepage      = 'https://github.com/ronaldchacon/yaqb'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'railties', '>= 4.2.0'
  spec.add_development_dependency 'rake', '~> 12.3.0'
  spec.add_development_dependency 'rspec', '~> 3.8.0'
end
