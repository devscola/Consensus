module Page
  class Login
    include Capybara::DSL

    def initialize
      url = '/login'
      visit(url)
      validate!
    end

    def warning_shown?
      has_css?('#warning')
    end

    def space_warning?
      has_css?('#space-warning')
    end

    def fill_user(username)
      fill_in('username', with: username)
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

    def password_masked?
      has_css?('#password[type="password"]')
    end

    def token?
      script = <<~SCRIPT
        return localStorage.getItem('authorized');
      SCRIPT

      token = execute_script(script)
      return true if token
      false
    end

    private

    def validate!
      page.assert_selector('#username')
      page.assert_selector('#password[type="password"]')
      page.assert_selector('#submit')
      page.assert_selector('#toggler')
      page.assert_selector('#space-warning', visible: false)
    end
  end
end
