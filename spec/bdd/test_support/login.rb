module Page
  class Login
    include Capybara::DSL

    def initialize
      url = '/login'
      visit(url)
      validate!
    end

    def warning_shown?
      has_css?('#warning.consensus-login')
    end

    def space_warning?
      has_css?('#space-warning.consensus-login')
    end

    def fill_user(username)
      fill_in('username', with: username)
    end

    def sign_in(username, password)
      fill_in('username', with: username)
      fill_in('password', with: password)
      find('#submit.consensus-login').click
    end

    def dismiss_wrong_credentials_warning
      find('#dismiss.consensus-login').click
    end

    def toggle_password_visibility
      find('#toggler.consensus-login').click
    end

    def password_masked?
      has_css?('#password[type="password"].consensus-login')
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
      page.assert_selector('#username.consensus-login')
      page.assert_selector('#password[type="password"].consensus-login')
      page.assert_selector('#submit.consensus-login')
      page.assert_selector('#toggler.consensus-login')
      page.assert_selector('#space-warning.consensus-login', visible: false)
    end
  end
end
