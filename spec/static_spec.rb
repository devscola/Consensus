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

  def fill_wrong_credentials
    fill_in 'username', with: 'wrong username'
    fill_in 'password', with: 'wrong password'
  end

  def redirected_to_home
    expect(page.title).to eq('Consensus home')
  end

  def warning_appears
    expect(page).to have_css('#error')
  end

  def warning_has_dismiss
    expect(page).to have_css('#dismiss-error')
  end

  def dismiss_error
    click_on 'dismiss-error'
    expect(page).to have_no_css('#error')
  end

  def username_is_empty
    expect(page.find('#username').value).to eq('') 
  end

  def password_is_empty
    expect(page.find('#password').value).to eq('') 
  end

  def username_gets_focus
    expect(page).to have_selector('#username:focus')
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

  scenario 'login error' do
    go_to_login

    fill_wrong_credentials
    send_form
    warning_appears
  end

  scenario 'dismiss error' do
    go_to_login

    fill_wrong_credentials
    send_form
    warning_appears
    warning_has_dismiss
    dismiss_error
    username_is_empty
    password_is_empty
    username_gets_focus
  end

end



