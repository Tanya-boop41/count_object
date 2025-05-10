# frozen_string_literal: true

require "screen/count_object"
require "capybara/rspec"
require "selenium-webdriver"
require "screen/base/screen_server"

Capybara.default_driver = :selenium_chrome
Capybara.save_path = "/tmp/screenshots"
Capybara.app = ScreenServer

RSpec.configure do |config|
  config.include Capybara::DSL, feature: true
  config.include Capybara::RSpecMatchers, feature: true

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
