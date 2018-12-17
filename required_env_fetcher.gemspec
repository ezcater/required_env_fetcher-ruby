# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "required_env_fetcher/version"

Gem::Specification.new do |spec|
  spec.name          = "required_env_fetcher"
  spec.version       = RequiredEnvFetcher::VERSION
  spec.authors       = ["ezCater, Inc"]
  spec.email         = ["engineering@ezcater.com"]

  spec.summary       = "Allow a default value to be used for a required environment variable"
  spec.description   = <<~DESC
    In certain situations it makes sense to allow default values of environment variables that
    are otherwise required. For example, imagine we're precompiling assets as part of CI when
    we don't have access to some environment variables we require for the app be up and
    accepting requests, but aren't required for asset compilation. Using this library we can
    designate it safe to use default values in those situations.
  DESC
  spec.homepage      = "https://github.com/ezcater/required_env_fetcher-ruby"

  spec.license       = "MIT"

  # Set "allowed_push_post" to control where this gem can be published.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  excluded_files = %w(.circleci/config.yml
                      .github/PULL_REQUEST_TEMPLATE.md
                      .gitignore
                      .rspec
                      .rubocop.yml
                      .ruby-gemset
                      .ruby-version
                      .travis.yml
                      bin/console
                      bin/setup
                      Rakefile)

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(/^(test|spec|features)\//)
  end - excluded_files
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"

  spec.add_development_dependency "ezcater_rubocop", "0.58.0"
  spec.add_development_dependency "overcommit"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rspec_junit_formatter", "0.2.2"
  spec.add_development_dependency "simplecov"
end
