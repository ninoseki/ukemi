# frozen_string_literal: true

require_relative "lib/ukemi/version"

Gem::Specification.new do |spec|
  spec.name = "ukemi"
  spec.version = Ukemi::VERSION
  spec.authors = ["Manabu Niseki"]
  spec.email = ["manabu.niseki@gmail.com"]

  spec.summary = "A CLI tool for querying passive DNS services"
  spec.description = "A CLI tool for querying passive DNS services"
  spec.homepage = "https://github.com/ninoseki/ukemi"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "coveralls_reborn", "~> 0.22"
  spec.add_development_dependency "overcommit", "~> 0.58"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "standard", "~> 1.1"
  spec.add_development_dependency "vcr", "~> 6.0"
  spec.add_development_dependency "webmock", "~> 3.14"

  spec.add_dependency "addressable", "~> 2.8"
  spec.add_dependency "dnsdb", "~> 0.1"
  spec.add_dependency "mem", "~> 0.1"
  spec.add_dependency "otx_ruby", "~> 0.9"
  spec.add_dependency "parallel", "~> 1.20"
  spec.add_dependency "passive_circl", "~> 0.1"
  spec.add_dependency "passivetotalx", "~> 0.1"
  spec.add_dependency "public_suffix", "~> 4.0"
  spec.add_dependency "securitytrails", "~> 1.0"
  spec.add_dependency "thor", "~> 1.1"
  spec.add_dependency "virustotalx", "~> 1.1"
end
