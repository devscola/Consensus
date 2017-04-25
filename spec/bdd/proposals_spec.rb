require 'spec_helper_bdd'
require_relative '../../app'
require_relative 'test_support/login'
require_relative 'test_support/proposals'
require_relative 'test_support/discussion_board'
require_relative 'test_support/fixture'

feature 'Proposal list' do
  scenario 'is empty before adding proposals' do
    current=Fixture.empty
    expect(current.any_proposal?).to be false
  end

  scenario 'shows proposals added' do
    current=Fixture.proposal_added
    expect(current.any_proposal?).to be true
  end

  scenario 'Links proposals to the discussion board' do
    Fixture.empty
    current=Fixture.proposal_added
    board = current.visit_proposal(Fixture::PROPOSAL_NAME)

    expect(board.proposal_title).to eq(Fixture::PROPOSAL_NAME)
  end

end

feature 'Proposal form'  do
  scenario 'is not visible until triggered' do
    expect(Fixture.at_proposals.form_visible?).to be false    
  end

  scenario 'appears when triggered' do
    expect(Fixture.proposal_form_shown.form_visible?).to be true
  end

  scenario 'Form disappears at proposal creation' do
    current=Fixture.proposal_added
    expect(current.form_visible?).to be false
  end

  scenario 'User selection appears after proposal creation' do
    current=Fixture.proposal_added
    expect(current.user_selection_is_visible?).to be true
  end
end

feature 'New proposal form' ,:wip do
 

  scenario 'counts number of characters' do
    some_text = 'some random text'
    character_amount = some_text.length

    current=Fixture.proposal_form_shown
    current.fill_content(some_text)

    expect(current.content_length).to eq(character_amount)
  end

  scenario 'enables submit on enough content' do
    current= Fixture.proposal_form_filled
    enough = current.submit_button_enabled?
  
    expect(enough).to eq(true)
  end

  xscenario 'disallows submit without enough content', :bug do
    current= Fixture.proposal_form_shown
    expect(current.submit_button_enabled?).to eq(false)
  end

  scenario 'notifies the need for enough content' do
    current= Fixture.proposal_form_shown
    expect(current.info_message_visible?).to eq(true)
  end

  scenario 'notification disappears when not needed' do
    current= Fixture.proposal_form_filled
    expect(current.info_message_visible?).to eq(false)
  end

  
end

feature 'Create circle' do
  let(:proposals) { Page::Proposals.new }
  before(:each) do
    empty_fixture
    username = 'KingRobert'
    password = 'Stag'
    login = Page::Login.new
    login.sign_in(username, password)
  end

  scenario 'Shows users of the system' do
    proposals.new_proposal('some title')
    expect(proposals.users_shown?).to be true
  end

  scenario 'Adding a user marks it as added' do
    the_user = 'Cersei'
    proposals.new_proposal('some title')
    proposals.click_user_button(the_user)

    expect(proposals.is_added?(the_user)).to be true
  end

  scenario 'Finishing disabled until user added' do
    proposals.new_proposal('some title')

    expect(proposals.button_finish_deactivated?).to be true
  end

  scenario 'Finishing enabled when user added', :not_deterministic do
    proposals.new_proposal('some title')
    proposals.click_user_button('Cersei')

    sleep 1
    expect(proposals.button_finish_deactivated?).to be false
  end

  scenario 'Finishing closes users selection' do
    proposals.new_proposal('some title')
    sleep 3
    proposals.click_user_button('Cersei')

    proposals.button_finish_click

    expect(proposals.user_selection_is_visible?).to be false
  end

  xscenario 'Adding a new proposal close users selection', :not_deterministic do
    proposals.new_proposal('some title')
    proposals.show_form

    expect(proposals.user_selection_is_visible?).to be false
  end
end

def empty_fixture
  visit('/proposals/empty')
end
