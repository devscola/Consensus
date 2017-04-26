require 'spec_helper_bdd'
require_relative 'test_support/login'
require_relative 'test_support/fixture'
require_relative '../../app'

feature 'Login Form' do
  let(:login_page) do
    Page::Login.new
  end

  scenario 'triggers warning on bad attempt' do
    username = Fixture::BAD_USERNAME
    password = Fixture::BAD_PASSWORD
    login_page.sign_in(username, password)

    expect(login_page.warning_shown?).to be true
  end

  scenario 'allows dissmissing warning' do
    current=Fixture.wrong_credentials_attempt
    current.dismiss_wrong_credentials_warning

    expect(current.warning_shown?).to be false
  end

  scenario 'shows clear password on demand' do
    login_page.toggle_password_visibility
    expect(page).to have_css('#password[type="text"]')
  end
  
  scenario 'shows secured password on demand' do
    current= Fixture.password_shown
    current.toggle_password_visibility
    expect(current.password_masked?).to be true
  end

  scenario 'stores a token when authorized', :wip do
    current=Fixture.user_logged
    expect(login_page.token?).to be true
  end

  scenario 'stores no token on bad attempt' do
    current=Fixture.wrong_credentials_attempt
    expect(current.token?).to be false
  end
    
  scenario 'shows warning on trailing spaces' do
    name = Fixture::VALID_USERNAME + '    '
    login_page.fill_user(name)
    expect(login_page.space_warning?).to be true
  end

end
