require 'spec_helper_bdd'
require_relative 'test_support/login'
require_relative '../../app'

feature 'Login' do
  let(:login_page) do
    Page::Login.new
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

  scenario 'Retrieve a token when authorized' do
    valid_username = 'KingRobert'
    valid_password = 'Stag'

    login_page.sign_in(valid_username, valid_password)
    result = login_page.token?


    expect(result).to eq(true)
  end

  scenario 'Retrieve a null when not authorized' do
    username = 'wadus'
    password = 'yolo'

    login_page.sign_in(username, password)
    result = login_page.token?


    expect(result).to eq(false)
  end

  context 'Spaces in the username' do

    scenario 'The warning not appears by default' do
      expect(login_page.space_warning?).to be false
    end

    scenario 'A warning appears when the last character in the username is a space' do
      name = 'Some username '

      login_page.fill_user(name)

      expect(login_page.space_warning?).to be true
    end
  
  end

end
