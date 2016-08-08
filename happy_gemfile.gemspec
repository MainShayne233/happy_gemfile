# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'happy_gemfile/version'

Gem::Specification.new do |spec|
  spec.name          = "happy_gemfile"
  spec.version       = HappyGemfile::VERSION
  spec.authors       = ["MainShayne233"]
  spec.email         = ["shaynetremblay@hotmail.com"]

  spec.summary       = %q{Alphabetizes your gems in your Gemfile! Makes life good!}
  spec.homepage      = "https://github.com/MainShayne233/happy_gemfile"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ["testforhappy"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
