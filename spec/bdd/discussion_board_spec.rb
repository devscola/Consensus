require 'spec_helper_bdd'
require_relative './test_support/discussion_board_page'
require_relative '../../app'

feature 'Discussion board page' do

  scenario 'it receives an url and shows a proposal' do
    proposal_id = 'an_id'
    expected_title = 'an_expected_title'
    discussion_board_page = Test::DiscussionBoardPage.new(proposal_id)

    result = discussion_board_page.proposal_title

    expect(result).to eq(expected_title)
  end

end
