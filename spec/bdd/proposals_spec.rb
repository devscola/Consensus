require 'spec_helper_bdd'
require_relative '../../app'
require_relative 'test_support/login'
require_relative 'test_support/proposals'
require_relative 'test_support/discussion_board'
require_relative 'test_support/fixture'

feature 'New proposal button' do
  scenario 'disallows create new proposal after clicked' do
    current = Fixture.user_logged
    current.show_form
    expect(current.new_proposal_enabled?).to be false
  end

  scenario 'enables create new proposal after circle finished' do
    current = Fixture.pristine.a_user_involved
    current.button_finish_click
    expect(current.new_proposal_enabled?).to be true
  end
end

feature 'Proposal list' do
  scenario 'shows proposals added' do
    current = Fixture.pristine.proposal_added
    expect(current.any_proposal?).to be true
  end

  scenario 'links every proposal to its discussion board' do
    current = Fixture.pristine.proposal_added
    board = current.visit_proposal(Fixture::PROPOSAL_NAME)
    expect(board.proposal_title).to eq(Fixture::PROPOSAL_NAME)
  end
end

feature 'Proposal form'  do
  scenario 'appears when triggered' do
    expect(Fixture.proposal_form_shown.form_visible?).to be true
  end

  scenario 'disappears at proposal creation' do
    current = Fixture.proposal_added
    expect(current.form_visible?).to be false
  end

  scenario 'counts number of characters' do
    current = Fixture.proposal_form_shown
    current.fill_content(Fixture::MEASURED_TEXT)

    expect(current.content_length).to eq(Fixture::MEASURED_TEXT_LENGTH)
  end

  scenario 'enables submit on enough content' do
    current = Fixture.proposal_form_filled
    enough = current.submit_button_enabled?

    expect(enough).to eq(true)
  end

  scenario 'disallows submit without enough content' do
    current = Fixture.proposal_form_shown
    expect(current.submit_button_enabled?).to eq(false)
  end

  scenario 'notifies the need for enough content' do
    current = Fixture.proposal_form_shown
    expect(current.info_message_visible?).to eq(true)
  end

  scenario 'notification disappears when not needed' do
    current = Fixture.proposal_form_filled
    expect(current.info_message_visible?).to eq(false)
  end
end

feature 'Circle selection' do
  scenario 'appears after proposal creation' do
    current = Fixture.proposal_added
    expect(current.user_selection_is_visible?).to be true
  end

  scenario 'shows users of the system' do
    current = Fixture.proposal_added
    expect(current.users_shown?).to be true
  end

  scenario 'marks users added' do
    the_user = Fixture::NOT_PROPOSER
    current = Fixture.pristine.proposal_added
    current.click_user_button(the_user)
    expect(current.is_added?(the_user)).to be true
  end

  scenario 'disallows finishing until at least one user added' do
    current = Fixture.proposal_added
    expect(current.button_finish_deactivated?).to be true
  end

  scenario 'allows finishing when user added' do
    current = Fixture.pristine.a_user_involved
    expect(current.button_finish_deactivated?).to be false
  end

  scenario 'disappears when finished' do
    current = Fixture.pristine.a_user_involved
    current.button_finish_click

    expect(current.user_selection_is_visible?).to be false
  end

  scenario 'allows closing without a single involved' do
    current = Fixture.proposal_added
    current.button_cancel_click
    expect(current.user_selection_is_visible?).to be false
  end

  scenario 'disallows canceling when user added' do
    current = Fixture.pristine.a_user_involved
    expect(current.button_cancel_deactivated?).to be true
  end
end
