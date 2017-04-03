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
      find('#proposal-submit').click
    end

    def any_proposal?
      has_css?('.proposal-entry')
    end

    def form_visible?
      has_css?('#proposal-form')
    end

    def user_selection_is_visible?
      has_css?('#user-selection')
    end

    def info_message_visible?
      message = find('#info-message', visible: false)
      message.visible?
    end

    def users_shown?
      has_content?('KingRobert') && has_content?('LyanaMormont')
    end

    def click_user_button(username)
      find('#' + username).click
    end

    def is_added?(username)
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
      find('#proposal-content').value.length.to_i
    end

    def button_finish_click
      find('#proposal-finish').click
    end

    def button_finish_deactivated?
      has_css?('#proposal-finish[disabled]', visible: false)
    end

    def do_show_form
      find('#create-proposal').click
    end

    private

    def validate!
      page.assert_selector('#create-proposal')
      page.assert_selector('#proposals-list', visible: false)
      page.assert_selector('#proposal-finish', visible: false)
      page.assert_selector('#user-selection', visible: false)
      page.assert_selector('#proposal-submit[disabled]', visible: false)
    end
  end
end
