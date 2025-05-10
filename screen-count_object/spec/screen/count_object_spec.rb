# frozen_string_literal: true

RSpec.describe Screen::CountObject do
  it "has a version number" do
    expect(Screen::CountObject::VERSION).not_to be nil
  end

it "is a correct descendant" do
  expect { Screen::Base.descendants_check!(1) }.not_to raise_error
end

# TODO: add tests for methods from the `descendants_check!`

  it "does something useful" do
    expect(false).to eq(true)
  end
end
