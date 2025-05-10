# frozen_string_literal: true

RSpec.describe Screen::Base do
  it "has a version number" do
    expect(Screen::Base::VERSION).not_to be nil
  end

  describe ".descendants_check!" do
    let(:screens_count) { 0 }

    it "should raise an error if there are descendants without needed methods" do
      expect { Screen::Base.descendants_check!(screens_count) }.not_to raise_error

      expect { Screen::Base.descendants_check!(screens_count + 1) }.to raise_error(
        LoadError,
        "Screens count missmatch: expected 1, got 0"
      )

      class Screen::TestScreen < Screen::Base ; end # TODO refactor [6XmqJR5RMvcQ4xrH]; right now we are going with the assumption check! method is called in the initializer only

      expect { Screen::Base.descendants_check!(screens_count + 1) }.to raise_error(
        NotImplementedError,
        "Method(s) :payload_schema, :preprocess_payload, :answer_errors is not implemented in Screen::TestScreen"
      )
    end
  end
end
