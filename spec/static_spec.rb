require 'rspec'
require 'sinatra'
require 'capybara'
require 'capybara/dsl'

require File.expand_path('../../server.rb', __FILE__)

Sinatra::Application.environment = :test
Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.default_driver = :chrome

describe 'Test environment' do
  it 'WORKS!' do
    visit('/index.html')
    expect(page.title).to eq('Consensus')
  end
end
