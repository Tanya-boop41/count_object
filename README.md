# Screen::Base

This is the ancestor for any Screen you're creating. It contains all the basic methods et.c.
Here and after, the doc will use `Screen::ClickDigit` as a Screen example.

### New Screen administrative checklist

1. Create a repo
1. Add gem to the `screeners` team
1. Enable CI/CD coverage
1. Forbid to push to master TODO [6XvRFQGJmMP45P3p]

## New Screen creation

Let's say you want to create a shiny new screen called `Screen::ClickDigit`.

1. `bundle gem screen-click_digit` - look at the dash and underscore! It's required by ruby conventions to make `ClickDigit` a separate module under `Screen` namespace.
2. If you're creating a gem for a first time, it will ask you for options. Select rspec, rubocop without any additional file (license, code of conduct et.c.)
3. Remove the `version.rb` file, it's obsolete. Just put a `0.1.0` to the `.gemspec`.
4. In the `.gemspec`, make the `spec.homepage = "https://github.com/madcrocodile/screen-click_digit"`. Both `spec.metadata["homepage_uri"] = spec.homepage` and `spec.metadata["source_code_uri"] = spec.homepage`, remove the `spec.metadata["changelog_uri"]`
5. Remove all `TODO` and `FIXME` from the `.gemspec`
6. Remove the `.md` file, it's not needed
7. In created folder, find all occurrences of `module ClickDigit` and replace these with a `class ClickDigit`. Screens are classes, not modules
8. Add dev dependencies & `screen-base` dependency to the `Gemfile`

```
gem "capybara", "~> 3.40"
gem "selenium-webdriver", "~> 4.32"
gem "launchy", "~> 3"

gem "screen-base", "~> 0.1.0", git: "git@github.com:madcrocodile/screen-base.git"
```

9. `bundle install`
10. Add a `Screen::Base` requiring code to the `screen/click_digit.rb`

```
unless defined?(Screen::Base)
  require "bundler"
  Bundler.setup(:default)

  $LOAD_PATH.find { |path| path.include?("screen-base") }.tap do |path|
    require "#{path}/screen/base"
  end
end
```

It will dynamically require `Screen::

11. Make a `Screen::ClickDigit` a descendant of `Screen::Base`. `class Screen::ClickDigit < Screen::Base`

12. Add these lines to the `spec_helper.rb`

```
require "screen/click_digit"
require "capybara/rspec"
require "selenium-webdriver"
require "screen/base/screen_server"

Capybara.default_driver = :selenium_chrome
Capybara.save_path = "/tmp/screenshots"
Capybara.app = ScreenServer

RSpec.configure do |config|
  config.include Capybara::DSL, feature: true
  config.include Capybara::RSpecMatchers, feature: true
```

13. Add these lines to `spec/screen/click_digit_spec.rb` after the version spec:

```
it "is a correct descendant" do
  expect { Screen::Base.descendants_check!(1) }.not_to raise_error
end

# TODO: add tests for methods from the `descendants_check!`
```

14. Write a feature spec in the `spec/screen/feature_spec.rb`

```
require "spec_helper"

RSpec.describe Screen::ClickDigit, type: :feature do
  let(:payload) { {} }
  let(:screen) { Screen::ClickDigit.new(payload:) }

  before :each do
    ScreenServer.set :screen, screen
  end

  it "clicks a digit" do
    # Write your feature spec here
  end
end

```

15. Add a view file `app/views/screen/click_digit/show.html.erb`

```
<div id="<%= screen.class.name %>" data-payload="<%= screen.payload.to_json %>"></div>

<script type="text/babel">
  Write your code here
</script>
```


### Developing the screen

Run the server with the `ruby $(bundle info screen-base --path)/bin/screen_server.rb ./lib/screen/click_digit.rb {}` - where the first is the path to the rendering class, and second is the json payload
