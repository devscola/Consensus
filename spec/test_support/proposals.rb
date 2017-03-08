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
      click_on('create-proposal')
      fill_in('proposal-title', with: title)
      fill_in('proposal-content', with: content)
    end
    
    def submit_proposal
      click_on('proposal-submit')
    end  

    private

    def validate!
      page.assert_selector('#create-proposal')
      page.assert_selector('#proposal-list', visible: false)
    end

  end
end
