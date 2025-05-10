#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/screen/base/screen_server"
screen_class_relative_path, payload = ARGV

# Require screen_class
screen_class_path = File.expand_path(screen_class_relative_path, Dir.pwd)
require screen_class_path

screen_class = screen_class_path.split("/").last.split(".").first.classify
screen_class = Object.const_get("Screen::#{screen_class}")

# Transform the payload
payload = JSON.parse(payload)

screen = screen_class.new(payload:)

ScreenServer.set :screen, screen
ScreenServer.run!
