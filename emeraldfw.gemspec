# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emeraldfw/version'

Gem::Specification.new do |spec|
  spec.name          = "emeraldfw"
  spec.version       = EmeraldFW::VERSION
  spec.authors       = ["Ed de Almeida"]
  spec.email         = ["edvaldoajunior@gmail.com"]

  spec.summary       = "Emerald Framework is a full stack web development frameword designed for the strong."
  spec.description   = "Emerald Framework is a full stack web development frameword designed for the strong. It enforces good programming practices; privileges convantion over configuration; completely separates UI and backend, amog other advantages."
  spec.homepage      = "https://github.com/EdDeAlmeidaJr/emeraldfw21"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"

  spec.add_runtime_dependency "slop", "~> 4.4"
  spec.add_runtime_dependency "json", "~> 2.0"
  spec.add_runtime_dependency "ruby-trello", "~> 1.5"
  spec.add_runtime_dependency "github_api", "~> 0.14"
  spec.add_runtime_dependency "colorize", "~> 0.8"

end
