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

  scenario 'shows involved including the proposer' do
    board = Fixture.proposal_visited
    expect(board.circle).to include(Fixture::PROPOSER, Fixture::INVOLVED)
  end

  scenario 'allows questioning when user involved' do
    Fixture.involved_logged
    board = Fixture.proposal_visited
    expect(board.question_button?).to be true
  end

  scenario 'disallows questioning when user not involved' do
    Fixture.not_involved_logged
    board = Fixture.proposal_visited
    expect(board.question_button?).to be false
  end

  scenario 'enables submit with enough text' do
    board = Fixture.involved_is_questioning
    board.fill_enough_text
    expect(board.submit_question_active?).to be true
  end

  scenario 'disables submit without enough text' do
    board = Fixture.involved_is_questioning
    board.fill_not_enough_text
    expect(board.submit_question_active?).to be false
  end

  scenario 'allows question writing' do
    board = Fixture.involved_is_questioning
    board.create_question
    expect(board.question_button_active?).to be false
    expect(board.question_content?).to be true
  end

  scenario 'disallows question writing after question submit' do
    board = Fixture.involved_is_questioning
    board.submit_question_form
    expect(board.question_form?).to be false
  end

  scenario 'disallows proposer to question' do
    Fixture.login
    board = Fixture.proposal_visited
    expect(board.question_button_visible?).to be false
  end

  scenario 'allows questioning after question submit' do
    board = Fixture.involved_is_questioning
    board.submit_question_form
    expect(board.question_button_active?).to be true
  end
end
