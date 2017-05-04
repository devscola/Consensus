require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative 'test_support/login'
require_relative 'test_support/fixture'
require_relative '../../app'

feature 'Discussion board' do
  before(:all) do
    Fixture.pristine
    Fixture.proposal_with_a_user_involved
  end

  scenario 'Shows circle users including the proposer' do
    board = Fixture.proposal_visited
    expect(board.circle).to include(Fixture::PROPOSER, Fixture::INVOLVED)
  end

  scenario 'Show question button if user in circle' do
    Fixture.involved_logged
    board = Fixture.proposal_visited
    expect(board.question_button?).to be true
  end

  scenario "Doesn't show question button if user not in circle" do
    Fixture.not_involved_logged
    board = Fixture.proposal_visited
    expect(board.question_button?).to be false
  end

  scenario 'Submit question activates when enough text' do
    board = Fixture.involved_is_questioning
    board.fill_enough_text
    expect(board.submit_question_active?).to be true
  end

  scenario 'Submit question doesnt activate without enough text' do
    board = Fixture.involved_is_questioning
    board.fill_not_enough_text
    expect(board.submit_question_active?).to be false
  end

  scenario 'Shows textarea when question button is clicked' do
    board = Fixture.involved_is_questioning
    board.create_question
    expect(board.question_button_active?).to be false
    expect(board.question_content?).to be true
  end

  scenario 'Does not show question button for proposal user' do
    Fixture.login
    board = Fixture.proposal_visited
    expect(board.question_button_visible?).to be false
  end

  scenario 'Question button enabled when question is submited' do
    board = Fixture.involved_is_questioning
    board.submit_question_form
    expect(board.question_button_active?).to be true
  end

  scenario 'Question form disabled when question is submited' do
    board = Fixture.involved_is_questioning
    board.submit_question_form
    expect(board.question_form?).to be false
  end
end
