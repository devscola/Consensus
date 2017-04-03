require 'spec_helper_bdd'
require_relative 'test_support/login'
require_relative '../../app'

feature "Login" do
  let(:login_page) do
    Page::Login.new
  end

  scenario 'Log with authorized credentials' do
    valid_username = 'KingRobert'
    valid_password = 'Stag'

    login_page.sign_in(valid_username, valid_password)

    expect(page).to have_css('#create-proposal')
  end

  scenario 'Attemp to login with bad credentials triggers warning' do
    username = 'wadus'
    password = 'yolo'

    login_page.sign_in(username, password)

    expect(page).to have_css('#warning')
  end

  scenario 'Warning is dismisseable' do
    username = 'wadus'
    password = 'yolo'
    login_page.sign_in(username, password)

    login_page.dismiss_wrong_credentials_warning

    expect(page).to have_no_css('#warning')
  end

  scenario 'Toggle password visualization' do
    login_page
    
    login_page.toggle_password_visibility
    expect(page).to have_css('#password[type="text"]')

    login_page.toggle_password_visibility
    expect(page).to have_css('#password[type="password"]')
  end

end
