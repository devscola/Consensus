module Page
  class Proposals
    include Capybara::DSL

    def initialize
      url = '/proposals'
      visit(url)
      validate!
    end

    def new_proposal(title, content)
      do_show_form
      fill_in('proposal-title', with: title)
      fill_in('proposal-content', with: content)
      click_on('proposal-submit')
    end

    def exist_proposal
      has_css?('.proposal-entry')
    end

    def form_visible?
      has_css?('#proposal-form')
    end

    def user_selection_is_visible?
      has_css?('#user-selection')
    end

    def user_list_is_visible?
      has_css?('#user-selection')
    end

    def info_message_visible?
      message = find('#info-message', visible: false)
      message.visible?
    end

    def user_amount
      page.all('.user').count
    end

    def click_user_button(username)
      click_on(username)
    end

    def symbol_exists?(username)
      has_css?('#' + username + '-checked')
    end

    def visit_proposal(name)
      click_link(name)
      return DiscussionBoard.new
    end

    def entries
      all_entries = []
      entries = page.all('.proposal-entry')

      entries.each do |node|
        entry = { identifier: node.text[0] }
        all_entries << entry
      end

      all_entries
    end

    def show_form
      do_show_form
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
      fill_in('proposal-content', with: ' ')
    end

    def content_length
      find('#proposal-content').value.length
    end

    def button_finish_click
      click_on('proposal-finish')
    end

    def button_finish_activate?
      button = find('#proposal-finish', visible: false)
      disabled = button[:disabled]
      !disabled
    end

    def do_show_form
      click_on('create-proposal')
    end

    private

    def validate!
      page.assert_selector('#create-proposal')
      page.assert_selector('#proposals-list', visible: false)
      page.assert_selector('#proposal-finish', visible: false)
    end
  end
end
