require 'sinatra'
require 'capybara'
require 'capybara/rspec'

Sinatra::Application.environment = :test
Capybara.app = Sinatra::Application

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :chrome

Capybara.app_host = "http://localhost:4567"
Capybara.server_host = "localhost"
Capybara.server_port = "4567"
