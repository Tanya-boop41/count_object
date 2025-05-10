# frozen_string_literal: true

require_relative "base/version"
require "active_model"
require "action_controller"
require "json-schema"

module Screen
  class Base
    def self.descendants_check!(screens_count)
      raise LoadError, "Screens count missmatch: expected #{screens_count}, got #{descendants.count}" if descendants.count != screens_count

      self.descendants.each do |descendant|
        missing_methods = []
        missing_methods << :payload_schema unless descendant.instance_methods.include?(:payload_schema)
        missing_methods << :preprocess_payload unless descendant.instance_methods.include?(:preprocess_payload)
        missing_methods << :answer_errors unless descendant.instance_methods.include?(:answer_errors)

        if missing_methods.any?
          missing_methods_string = missing_methods.map { |method| ":#{method}" }.join(", ")
          raise NotImplementedError, "Method(s) #{missing_methods_string} is not implemented in #{descendant.name}"
        end
      end
    end

    include ::ActiveModel::Model

    validate :payload_matches_schema

    attr_reader :payload, :answer

    def initialize(payload: nil, answer: nil)
      @payload = payload unless payload.nil?
      @answer = answer unless answer.nil?
    end

    def render
      action_controller = ::ActionController::Base.new
      action_controller.render_to_string(
        inline: open(view_path).read,
        locals: { screen: self },
        layout: false,
        formats: [:html]
      )
    end

    private

    def view_path
      screen_path = Object.const_source_location(self.class.name).first
      File.expand_path("../../../app/views/#{self.class.name.underscore}/show.html.erb", screen_path)
    end

    DEFAULT_OPTIONS = {
      additionalProperties: false
    }.freeze

    def payload_matches_schema
      json_errors = JSON::Validator.fully_validate(DEFAULT_OPTIONS.merge(payload_schema), payload)
      json_errors.each do |error|
        message = error.gsub("The property '#/' ", "").sub(/ in schema.*/, "").capitalize
        errors.add(:base, message)
      end
    end
  end
end
#
