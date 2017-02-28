module Page
  class Button
    include Capybara::DSL

    def initialize
      url = '/button.html'
      visit(url)
      validate!
    end

    def is_button_activated?
      page.has_button?('conditionedButton', disabled: false)
    end

    def validate!
      page.assert_selector('#conditionedButton')
      page.assert_selector('#condition')
    end
  end
end
