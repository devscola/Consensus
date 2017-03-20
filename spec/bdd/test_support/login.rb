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
      click_button('submit')
    end

    def dismiss_wrong_credentials_warning
      click_button('dismiss-error')
    end

    def toggle_password_visibility
      find('#password-toggler').click
    end

    private

    def validate!
      page.assert_selector('#username')
      page.assert_selector('#password')
      page.assert_selector('#submit')
      page.assert_selector('#password-toggler')
    end
  end
end
