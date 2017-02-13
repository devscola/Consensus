require 'rspec'
require 'sinatra'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

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

feature 'Login form' do

  CREDENTIALS = { username: 'KingRobert', password: 'Stag' }

  def go_to_login
    visit('/index.html')
  end

  def fill_proper_credentials
    fill_in 'username', with: CREDENTIALS[:username]
    fill_in 'password', with: CREDENTIALS[:password]
  end

  def send_form
    click_on 'submit'
  end

  def redirected_to_home
    expect(page.title).to eq('Consensus home')
  end

  scenario 'has a username field' do
    go_to_login

    expect(page).to have_css('#username')
  end

  scenario 'has a password field' do
    go_to_login

    expect(page).to have_css('#password')
    expect(page).to have_css('#password[type="password"]')
  end

  scenario 'has a submit button' do
    go_to_login

    expect(page).to have_css('#submit')
  end

  scenario 'login success' do
    go_to_login

    fill_proper_credentials
    send_form
    redirected_to_home
  end
end



