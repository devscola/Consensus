require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative '../../app'

feature 'Discussion board' do
  scenario 'Lists users at selection' do
    users = ['Cersei', 'Arya', 'KingRobert']
    the_proposal = 'list user at selection title'
    visit('/proposals/empty')
    proposals = Page::Proposals.new

    proposals.new_proposal(the_proposal)
    users.each do |user|
      proposals.click_user_button(user)
    end
    proposals.button_finish_click
    board = proposals.visit_proposal(the_proposal)

    expect(board.circle).to eq(users.sort)
  end
end
