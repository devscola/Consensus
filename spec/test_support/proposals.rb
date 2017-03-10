module Page
  class Proposals
    include Capybara::DSL

    def initialize
      url = '/proposals'
      visit(url)
      validate!
    end

    def proposal_amount
      page.all('.proposal-entry').count
    end

    def form_is_visible?
      return :visible if page.has_css?('#proposal-form', visible: true)
      :invisible
    end

    def new_proposal(title, content)
      show_form
      fill_in('proposal-title', with: title)
      fill_in('proposal-content', with: content)
    end

    def go_to_first
    end

    def show_form
      click_on('create-proposal')
    end

    def submit_proposal
      click_on('proposal-submit')
    end

    def info_message_visible?
      message = find('#info-message', visible: false)
      message.visible?
    end

    def submit_button_enabled?
      button = find('#proposal-submit')
      result = button[:disabled]

      return true if result.nil?

      false
    end

    def fill_content(content)
      fill_in('proposal-content', with: content)
    end

    def remove_content
      fill_in('proposal-content', with: " ")
    end

    def content_length
      find('#proposal-content').value.length
    end

    private

    def validate!
      page.assert_selector('#create-proposal')
      page.assert_selector('#proposal-list', visible: false)
    end

  end
end
