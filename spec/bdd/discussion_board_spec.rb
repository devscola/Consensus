require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative '../../app'

feature 'Discussion board', :wip do
  scenario 'Lists users at selection' do
    users = ['Cersei', 'Arya', 'KingRobert']
    the_proposal = 'some title'
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

  scenario 'Request user at circle', :wip do
    users = ['Cersei', 'Arya', 'KingRobert']
    the_proposal = 'some title'
    visit('/proposals/empty')
    proposals = Page::Proposals.new

    proposals.new_proposal(the_proposal)
    users.each do |user|
      proposals.click_user_button(user)
    end
    proposals.button_finish_click
    board = proposals.visit_proposal(the_proposal)

    username = 'KingRobert'

    result = board.user_in_circle?(username)

    expect(result).to be true
  end
end
