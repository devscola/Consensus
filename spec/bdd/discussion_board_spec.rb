require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative 'test_support/login'
require_relative '../../app'

feature 'Discussion board' do
    before(:each) do
      username = 'KingRobert'
      password = 'Stag'
      login = Page::Login.new
      login.sign_in(username, password)
    end

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

  scenario 'Request user at circle' do
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
  scenario 'Show question button if user in circle' do
    users = ['KingRobert', 'Arya']
    the_proposal = 'some title'
    visit('/proposals/empty')
    proposals = Page::Proposals.new
    proposals.new_proposal(the_proposal)
    users.each do |user|
      proposals.click_user_button(user)
    end
    proposals.button_finish_click

    username = 'KingRobert'
    password = 'Stag'
    login = Page::Login.new
    login.sign_in(username, password)

    board = proposals.visit_proposal(the_proposal)

    expect(board.question_button?).to be true
  end
  scenario "Doesn't show question button if user not in circle" do
    users = ['Cersei', 'Arya']
    the_proposal = 'some title'
    visit('/proposals/empty')
    proposals = Page::Proposals.new
    proposals.new_proposal(the_proposal)
    users.each do |user|
      proposals.click_user_button(user)
    end
    proposals.button_finish_click

    username = 'KingRobert'
    password = 'Stag'
    login = Page::Login.new
    login.sign_in(username, password)

    board = proposals.visit_proposal(the_proposal)

    expect(board.question_button?).to be false
  end
end
