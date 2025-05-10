require "spec_helper"

RSpec.describe Screen::CountObjects, type: :feature do
  let(:payload) { {} }
  let(:screen) { Screen::CountObjects.new(payload:) }

  before :each do
    ScreenServer.set :screen, screen
  end

  it "clicks a digit" do
    # Write your feature spec here
  end
end
