require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative 'test_support/login'
require_relative 'test_support/fixture'
require_relative '../../app'

xfeature 'Discussion board' do

  scenario 'Shows circle users including the proposer' do
    current = Fixture.pristine.a_user_involved
    board = current.visit_proposal(Fixture::PROPOSAL_NAME)
    expect(board.circle).to include(Fixture::PROPOSER, Fixture::INVOLVED)
  end

  scenario 'Show question button if user in circle' do
    Fixture.pristine.a_user_involved
    current = Fixture.involved_logged
    board = current.visit_proposal(Fixture::PROPOSAL_NAME)
    expect(board.question_button?).to be true
  end

  scenario "Doesn't show question button if user not in circle" do
    Fixture.pristine.a_user_involved
    current = Fixture.not_involved_logged
    board = current.visit_proposal(Fixture::PROPOSAL_NAME)
    expect(board.question_button?).to be false
  end

  scenario 'Submit question activates when enough text' do
    current = Fixture.pristine.involved_questioning
    current.fill_question(Fixture.enough_text)
    expect(current.submit_question_active?).to be true
  end

  scenario 'Submit question doesnt activate without enough text' do
    board = Fixture.pristine.involved_questioning
    board.fill_question(Fixture.enough_text[0...-1])
    expect(board.submit_question_active?).to be false
  end

  scenario 'Shows textarea when question button is clicked' do
    board = Fixture.pristine.involved_questioning
    board.create_question
    expect(board.question_button_active?).to be false
    expect(board.question_content?).to be true
  end

  scenario 'Does not show question button for proposal user' do
    current = Fixture.pristine.a_user_involved
    board = current.visit_proposal(Fixture::PROPOSAL_NAME)
    expect(board.question_button_visible?).to be false
  end

  scenario 'Question button enabled when proposal is submited' do
    current = Fixture.pristine.involved_asked
    expect(current.question_button_active?).to be true
  end

  scenario 'Question form disabled when proposal is submited' do
    current = Fixture.pristine.involved_asked
    expect(current.question_form?).to be false
  end
end
