# frozen_string_literal: true

require_relative "lib/screen/base/version"

Gem::Specification.new do |spec|
  spec.name = "screen-base"
  spec.version = Screen::Base::VERSION
  spec.authors = ["Aleksandr Antonov"]
  spec.email = ["kaburbundokel11g@inbox.ru"]

  spec.summary = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://github.com/madcrocodile/screen-base"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.executables = ["screen_server"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "json-schema", ">= 5"
  spec.add_dependency "puma", ">= 6"
  spec.add_dependency "rails", ">= 8"
  spec.add_dependency "sinatra", ">= 4"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
