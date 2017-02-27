class NewProposalPage
  include Capybara::DSL

  def initialize
   url = '/new-proposal.html'
   visit(url)
   validate!
  end
  def fill_title(title)
    fill_in('proposal-title', with: title)
  end
  def fill_content(content)
    fill_in('proposal-content', with: content)
  end
  def get_title_value
  	find('#proposal-title').value
  end
  def get_content_value
  	find('#proposal-content').value
  end

  private

  def validate!
      page.assert_selector("#proposal-title")
      page.assert_selector("#proposal-content")
      page.assert_selector("#proposal-submit")
  end
end
