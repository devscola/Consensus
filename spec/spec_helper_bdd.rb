require 'sinatra'
require 'capybara'
require 'capybara/rspec'

Sinatra::Application.environment = :test
Capybara.app = Sinatra::Application

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :chrome