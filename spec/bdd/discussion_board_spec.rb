require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative 'test_support/fixtures'
require_relative '../../app'

feature 'Discussion board' do
  scenario 'shows users involved in the proposal' do
    visit('/proposals/empty')
    proposals = Page::Proposals.new
    proposals.new_proposal('strange title', some_enough_proposal_content)
    proposals.click_user_button('Cersei')
    board = proposals.visit_proposal('strange title')

    result = board.users_listed?

    expect(result).to be true
  end

  def some_enough_proposal_content
    Fixtures.enough_proposal_content
  end
end
