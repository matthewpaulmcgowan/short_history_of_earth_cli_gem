# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'short_history_of_earth/version'
gem 'short_history_of_earth'

Gem::Specification.new do |spec|
  spec.name          = "short_history_of_earth"
  spec.version       = ShortHistoryOfEarth::VERSION
  spec.authors       = ["matthewpaulmcgowan"]
  spec.email         = ["matthewpaulmcgowan@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = "Combines two timelines and adds a CLI to interact with the data"
  spec.description   = "The project scrapes history of the maya data and archeological and science history. The data is then searchable by year via a command line interface."
  spec.homepage      = "https://github.com/matthewpaulmcgowan/short_history_of_earth_cli_gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  
  spec.add_dependency "nokogiri"
end
