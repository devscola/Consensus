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

    def new_proposal(title, content)
      click_on('new-proposal')
      fill_in('proposal-content', with: content)
    end

    private

    def validate!
      page.assert_selector('#new-proposal')
      page.assert_selector('#proposal-list', visible: false)
    end

    def proposal_content
      Fixtures.enought_proposal_content
    end
  end
end
