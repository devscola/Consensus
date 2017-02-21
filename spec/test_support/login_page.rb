module TestSupport
  class LoginPage
    include Capybara::DSL

    def initialize
      url = 'localhost:4567/index.html'
      visit(url)
    end

    def login(username, password)
      fill_in('username', with: username)
      fill_in('password', with: password)
      click_button('submit')
    end
  end
end
