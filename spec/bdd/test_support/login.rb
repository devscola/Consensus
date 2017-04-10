module Page
  class Login
    include Capybara::DSL

    def initialize
      url = '/login'
      visit(url)
      validate!
    end

    def sign_in(username, password)
      fill_in('username', with: username)
      fill_in('password', with: password)
      find('#submit').click
    end

    def dismiss_wrong_credentials_warning
      find('#dismiss').click
    end

    def toggle_password_visibility
      find('#toggler').click
    end

    private

    def validate!
      page.assert_selector('#username')
      page.assert_selector('#password[type="password"]')
      page.assert_selector('#submit')
      page.assert_selector('#toggler')
    end
  end
end
