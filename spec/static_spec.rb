require 'spec_helper'
require File.expand_path('../../app.rb', __FILE__)

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
    # sleep 30
    expect(page).to have_title('Consensus home')
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

  def password_is_hidden
    expect(page).to have_css('#password[type="password"]')
  end
  
  def toggle_password_visibility
    click_on 'togglePassword' 
  end

  def password_is_shown
    expect(page).to have_css('#password[type="text"]')
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

  scenario 'Toggle login password visualization' do
    go_to_login

    fill_proper_credentials
    password_is_hidden
    toggle_password_visibility
    password_is_shown
    toggle_password_visibility
    password_is_hidden
  end

end



