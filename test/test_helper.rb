ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"

Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_actual_hour
    Hour.create!(code: '123', day: Time.now.wday, hour: 1, start: Time.now.beginning_of_hour.hh_mm, end: (Time.now + 1.hour).beginning_of_hour.hh_mm)
  end
end
