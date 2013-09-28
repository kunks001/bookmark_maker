# Generated by cucumber-sinatra. (2013-09-25 10:44:27 +0100)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'app', 'server.rb')

require 'capybara'
require 'capybara/cucumber'
require 'email_spec'
require 'email_spec/cucumber'
require 'rspec'
require 'database_cleaner'

Capybara.app = Server

class ServerWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  ServerWorld.new
end