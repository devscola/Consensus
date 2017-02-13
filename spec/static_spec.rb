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

describe 'Login form' do

  def go_to_login
    visit('/index.html')
  end

  it 'has a username field' do
    go_to_login

    expect(page).to have_css('#username')
  end

  it 'has a password field' do
    go_to_login

    expect(page).to have_css('#password')
    expect(page).to have_css('#password[type="password"]')
  end

  it 'has a submit button' do
    go_to_login

    expect(page).to have_css('#submit')
  end
end
