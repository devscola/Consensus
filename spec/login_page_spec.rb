require 'spec_helper'
require_relative 'test_support/login_page'
require_relative '../app'

feature "Login" do
  let(:login_page) do
    TestSupport::LoginPage.new
  end

  scenario 'login success' do
    username = 'KingRobert'
    password = 'Stag'

    login_page.login(username, password)

    expect(page).to have_title('Consensus home')
  end
end
