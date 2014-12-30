require 'minitest/autorun'
require 'test_xml/mini_test'

ENV['RAILS_ENV'] = 'test'
require "dummy/config/environment"
require "rails/test_help" # adds stuff like @routes, etc.
require "roar/rails/test_case"

Singer = Struct.new(:name)

# Rails.backtrace_cleaner.remove_silencers!

Mime::Type.register 'application/hal+json', :hal



# via https://github.com/jingweno/msgpack_rails/issues/3
renderer = Proc.new do |js, options|
  self.content_type ||= Mime::HAL
  js.is_a?(String) ? js : js.to_json
end

if ::Rails::VERSION::MAJOR >= 4 && ::Rails::VERSION::MINOR >= 1
  ::ActionController::Renderers.add(:hal, &renderer)
else
  ::ActionController.add_renderer(:hal, &renderer)
end
