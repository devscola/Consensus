module Page
  class NewProposalPage
    include Capybara::DSL

    def initialize
     url = '/new-proposal.html'
     visit(url)
    end
  end
end
