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

  scenario 'Shows circle users including the proposer' do
    proposer = 'KingRobert'
    users = ['Cersei', 'Arya']
    the_proposal = 'some title'
    visit('/proposals/empty')
    proposals = Page::Proposals.new

    proposals.new_proposal(the_proposal)
    users.each do |user|
      proposals.click_user_button(user)
    end
    proposals.button_finish_click
    users << proposer

    board = proposals.visit_proposal(the_proposal)

    expect(board.circle).to eq(users.sort)
  end

  scenario 'Show question button if user in circle' do
    proposals = new_proposal_with_Arya_involved_and_visit_with_her('A Proposal')
    
    board = proposals.visit_proposal('A Proposal')

    expect(board.question_button?).to be true
  end

  scenario "Doesn't show question button if user not in circle" do
    user = 'Arya'
    the_proposal = 'some title'
    visit('/proposals/empty')
    proposals = Page::Proposals.new

    proposals.new_proposal(the_proposal)
    proposals.click_user_button(user)
    proposals.button_finish_click

    username = 'Varys'
    password = 'Bird'
    login = Page::Login.new
    login.sign_in(username, password)

    board = proposals.visit_proposal(the_proposal)

    expect(board.question_button?).to be false
  end

  scenario 'Submit question activates when enough text' do
    proposals = new_proposal_with_Arya_involved_and_visit_with_her('A Proposal')
    board = proposals.visit_proposal('A Proposal')
    board.create_question
    board.fill_question(enough_text)
    expect(board.submit_question_active?).to be true
  end

  scenario 'Submit question doesnt activate without enough text' do
    proposals = new_proposal_with_Arya_involved_and_visit_with_her('A Proposal')
    board = proposals.visit_proposal('A Proposal')
    board.create_question
    board.fill_question('not enough text to activate')
    expect(board.submit_question_active?).to be false
  end

  scenario 'Shows textarea when question button is clicked' do
    proposals = new_proposal_with_Arya_involved_and_visit_with_her('A Proposal')
    board = proposals.visit_proposal('A Proposal')

    board.create_question

    expect(board.question_button_active?).to be false
    expect(board.question_content?).to be true
  end

  scenario 'Does not show question button for proposal user' do
    board = new_proposal_with_Arya_involved

    expect(board.question_button_visible?).to be false
  end

  scenario 'Shows question button for not proposal user' do
    the_proposal = 'some title'
    proposals = new_proposal_with_Arya_involved_and_visit_with_her(the_proposal)

    board = proposals.visit_proposal(the_proposal)

    expect(board.question_button_visible?).to be true
  end

  scenario 'Question button enabled when proposal is submited' do
    proposals = new_proposal_with_Arya_involved_and_visit_with_her('a_proposal')
    board = proposals.visit_proposal('a_proposal')

    board.create_question
    board.fill_question(enough_text)
    board.submit_question_form

    expect(board.question_button_active?).to be true
  end

  scenario 'Question form disabled when proposal is submited' do
    proposals = new_proposal_with_Arya_involved_and_visit_with_her('a_proposal')
    board = proposals.visit_proposal('a_proposal')

    board.create_question
    board.fill_question(enough_text)
    board.submit_question_form

    expect(board.question_form?).to be false
  end

  def new_proposal_with_Arya_involved
    user = 'Arya'
    the_proposal = 'some title'
    visit('/proposals/empty')
    proposals = Page::Proposals.new

    proposals.new_proposal(the_proposal)
    proposals.click_user_button(user)
    proposals.button_finish_click
    proposals.visit_proposal(the_proposal)
  end

  def enough_text
    enough_length_text= ''
    101.times{enough_length_text<<'a'}
    enough_length_text
  end

  def new_proposal_with_Arya_involved_and_visit_with_her(the_proposal)
    user = 'Arya'
    password = 'Wolf'
    visit('/proposals/empty')
    proposals = Page::Proposals.new
    proposals.new_proposal(the_proposal)
    proposals.click_user_button(user)
    proposals.button_finish_click
    proposals.visit_proposal(the_proposal)
    login = Page::Login.new
    login.sign_in(user, password)
    proposals
  end
end
