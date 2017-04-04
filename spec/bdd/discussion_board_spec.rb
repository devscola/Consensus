require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative '../../app'

feature 'Discussion board' do
  scenario 'shows users involved in the proposal' do
    visit('/proposals/empty')
    proposals = Page::Proposals.new
    proposals.new_proposal('strange title')
    proposals.click_user_button('Cersei')
    board = proposals.visit_proposal('strange title')

    result = board.users_listed?

    expect(result).to be true
  end
end
