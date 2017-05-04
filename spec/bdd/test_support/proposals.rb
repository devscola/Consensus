module Page
  class Proposals
    include Capybara::DSL

    ENOUGH_CONTENT = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. AA'

    def initialize
      url = '/proposals'
      visit(url)
      validate!
    end

    def new_proposal(title)
      do_show_form
      fill_in('title', with: title)
      fill_enough_content
      find('#submit.proposal-form').click
    end

    def any_proposal?
      has_css?('.proposal-entry', wait: 1)
    end

    def form_visible?
      has_css?('#form.proposal-form')
    end

    def user_selection_is_visible?
      has_css?('#user-selection.proposal-circle', wait: 2)
    end

    def info_message_visible?
      message = find('#info-message.proposal-form', visible: false)
      message.visible?
    end

    def users_shown?
      has_content?('KingRobert', wait: 1) && has_content?('LyanaMormont', wait: 1)
    end

    def click_user_button(username)
      find("button[name=#{username}]", wait: 10).click
    end

    def is_added?(username)
      has_css?('#' + username + '-checked.proposal-circle')
    end

    def visit_proposal(name)
      click_link(name, wait: 4)
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

    def new_proposal_enabled?
      button = find('#newProposal.create-proposal')
      result = button[:disabled]
      return true if result.nil?
      false
    end

    def submit_button_enabled?
      button = find('#submit.proposal-form')
      result = button[:disabled]

      return true if result.nil?

      false
    end

    def fill_content(content)
      fill_in('content', with: content)
    end

    def remove_content
      fill_in('content', with: ' ')
    end

    def content_length
      find('#content.proposal-form').value.length.to_i
    end

    def button_finish_click
      find('#proposal-finish.proposal-circle').click
    end

    def button_cancel_click
      find('#proposal-cancel.proposal-circle', wait: 2).click
    end

    def button_finish_deactivated?
      has_css?('#proposal-finish.proposal-circle[disabled]', wait: 2)
    end

    def button_cancel_deactivated?
      has_css?('#proposal-cancel.proposal-circle[disabled]', wait: 2)
    end

    def button_finish_activated?
      find('#proposal-finish.proposal-circle').has_no_content?('disabled')
    end

    def do_show_form
      find('#newProposal.create-proposal', wait: 2).click
    end

    def fill_enough_content
      script = <<~SCRIPT
        content = document.getElementById('content');
        content.value = '#{ENOUGH_CONTENT}';
        form = document.getElementById('form-container');
        form.updateCounter();
      SCRIPT
      execute_script(script)
    end

    private

    def stub_authorization_token
      script = <<~SCRIPT
        var currentToken = localStorage.getItem('authorized');
        if(currentToken === undefined) {
          fakeToken = 'sometesttoken';
          localStorage.setItem('authorized', fakeToken);
        };
      SCRIPT
      execute_script(script)
    end

    def validate!
      page.assert_selector('#newProposal.create-proposal', visible: false)
      page.assert_selector('#proposals-container', visible: false)
      page.assert_selector('#proposal-finish.proposal-circle', visible: false)
      page.assert_selector('#user-selection.proposal-circle', visible: false)
      page.assert_selector('#submit.proposal-form', visible: false)
      page.assert_selector('#form.proposal-form', visible: false)
    end
  end
end
