require 'spec_helper_bdd'
require_relative 'test_support/login'
require_relative '../../app'

feature "Login" do
  let(:login_page) do
    Page::Login.new
  end

  scenario 'login success' do
    username = 'KingRobert'
    password = 'Stag'

    login_page.sign_in(username, password)

    expect(page).to have_title('Consensus home')
  end

  scenario 'login with empty credentials' do
    username = ''
    password = ''

    login_page.sign_in(username, password)

    expect_warning_has_appeared
  end

  scenario 'login with wrong credentials' do
    username = 'wadus'
    password = 'yolo'

    login_page.sign_in(username, password)

    expect_warning_has_appeared
  end

  scenario 'wrong credentials warning is dismisseable' do
    username = 'wadus'
    password = 'yolo'
    login_page.sign_in(username, password)

    login_page.dismiss_wrong_credentials_warning

    expect_warning_has_disappeared
  end

  scenario 'Toggle login password visualization' do
    login_page

    expect_password_to_be_hidden

    login_page.toggle_password_visibility

    expect_password_to_be_visible

    login_page.toggle_password_visibility

    expect_password_to_be_hidden
  end

  def expect_warning_has_appeared
    expect(page).to have_css('#error')
  end

  def expect_warning_has_disappeared
    expect(page).to have_no_css('#error')
  end

  def expect_password_to_be_visible
    expect(page).to have_css('#password[type="text"]')
  end

  def expect_password_to_be_hidden
    expect(page).to have_css('#password[type="password"]')
  end
end
