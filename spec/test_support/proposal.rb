module Page
  class Proposal
    include Capybara::DSL

    def initialize
      url = '/proposal'
      visit(url)
      validate!
    end

    def fill_content(content)
      fill_in('proposal-content', with: content)
    end

    def remove_content
      fill_in('proposal-content', with: " ")
    end

    def submit_button_enabled?
      button = find('#proposal-submit')
      result = button[:disabled]

      return true if result.nil? 

      false
    end

    def content_length
      find('#proposal-content').value.length
    end
 
    private
 
    def validate!
      page.assert_selector("#proposal-title")
      page.assert_selector("#proposal-content")
      page.assert_selector("#proposal-submit")
    end
  end
end
