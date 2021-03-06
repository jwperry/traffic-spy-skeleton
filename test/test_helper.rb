ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require(:test)


require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'capybara'
require 'database_cleaner'
require 'tilt/erb'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = TrafficSpy::Server

class Minitest::Test
  
    def setup
      DatabaseCleaner.start
    end

    def teardown
      DatabaseCleaner.clean
    end

end

class ControllerTestSetup < Minitest::Test
  include Rack::Test::Methods
  def app
    TrafficSpy::Server
  end

end

class FeatureTest < ControllerTestSetup
  include Capybara::DSL
end
