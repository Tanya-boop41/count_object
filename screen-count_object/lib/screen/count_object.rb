# frozen_string_literal: true

require_relative "../../../lib/screen/base"
require "json-schema"

unless defined?(Screen::Base)
  require "bundler"
  Bundler.setup(:default)

  screen_base_path = $LOAD_PATH.find { |path| path.include?("screen-base") }

  unless screen_base_path
    gem_path = Bundler.rubygems.find_name("screen-base").first.full_gem_path
    $LOAD_PATH.unshift("#{gem_path}/lib")
    require "screen/base"
  else
    require "#{screen_base_path}/screen/base"
  end
end


module Screen
  class CountObject < Screen::Base
    class Error < StandardError; end
    def payload_schema
      {
        type: "object",
        properties: {
          digit: { type: "integer", minimum: 0, maximum: 9 }
        },
        required: ["digit"]
      }
    end

    #def preprocess_payload
      # Обработка перед рендером, если нужно
    #end

    #def answer_errors
    #  []
    #end
  end
end
