module Page
  class TextArea
    include Capybara::DSL

    def initialize
      url = '/text-area.html'
      visit(url)
      validate!
    end

    def fill_text_area(text)
      fill_in('text-area', with: text)
    end

    def get_counter_value
      find('#counter').text
    end

    private

    def validate!
      page.assert_selector('#text-area')
      page.assert_selector('#counter')
    end
  end
end
