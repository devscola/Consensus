module Page
  class Proposals
    include Capybara::DSL

    def initialize
      url = '/proposals'
      visit(url)
      validate!
    end

    def list
      []
    end

    def form_is_visible?
      return :visible if page.has_css?('#proposal-form', visible: true)
      :invisible
    end

    def new_proposal(title, content)
      click_on('create-proposal')
      fill_in('proposal-title', with: proposal_content)
      fill_in('proposal-content', with: proposal_content)
    end

    private

    def validate!
      page.assert_selector('#create-proposal')
      page.assert_selector('#proposal-list', visible: false)
    end

    def proposal_content
      Fixtures.enough_proposal_content
    end
  end
end
