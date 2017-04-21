require 'spec_helper_bdd'
require_relative '../../app'
require_relative 'test_support/login'
require_relative 'test_support/proposals'
require_relative 'test_support/discussion_board'

feature 'Proposals' do
  before(:each) do
    username = 'KingRobert'
    password = 'Stag'
    login = Page::Login.new
    login.sign_in(username, password)
  end
  let(:proposals) { Page::Proposals.new }

  scenario 'List is empty before adding proposals' do
    empty_fixture
    expect(proposals.any_proposal?).to be false
  end

  scenario 'Lists proposals added', :not_deterministic do
    proposals.new_proposal('some title')
    expect(proposals.any_proposal?).to be true
  end

  scenario 'Form appears when triggered' do
    previous = proposals.form_visible?
    proposals.show_form

    expect(previous).to be false
    expect(proposals.form_visible?).to be true
  end

  scenario 'Form disappears at proposal creation', :not_deterministic do
    username = 'KingRobert'
    password = 'Stag'
    login = Page::Login.new
    login.sign_in(username, password)

    proposals.new_proposal('some title')
    sleep 0.5
    expect(proposals.form_visible?).to be false
  end

  scenario 'User selection appears after proposal creation' do
    proposals.new_proposal('some title')

    expect(proposals.user_selection_is_visible?).to be true
  end
end

feature 'New proposal form' do
  let(:proposals) { Page::Proposals.new }
  before(:each) do
    username = 'KingRobert'
    password = 'Stag'
    login = Page::Login.new
    login.sign_in(username, password)
  end

  scenario 'Counts number of characters' do
    some_text = 'some random text'
    character_amount = some_text.length

    proposals.show_form
    proposals.fill_content(some_text)

    expect(proposals.content_length).to eq(character_amount)
  end

  scenario 'Toggles button on content length' do
    proposals.show_form
    proposals.fill_enough_content

    enough = proposals.submit_button_enabled?
    proposals.remove_content

    expect(enough).to eq(true)
    expect(proposals.submit_button_enabled?).to eq(false)
  end

  scenario 'Toggles message on content length' do
    proposals.show_form
    proposals.fill_enough_content

    shown = proposals.info_message_visible?
    proposals.remove_content

    expect(shown).to eq(false)
    expect(proposals.info_message_visible?).to eq(true)
  end

  scenario 'Links proposals to the discussion board' do
    empty_fixture
    the_proposal = 'The Proposal'
    proposals.new_proposal(the_proposal)

    board = proposals.visit_proposal(the_proposal)

    expect(board.proposal_title).to eq(the_proposal)
  end
end

feature 'Create circle' do
  let(:proposals) { Page::Proposals.new }
  before(:each) do
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
    proposals.click_user_button('Cersei')

    proposals.button_finish_click

    expect(proposals.user_selection_is_visible?).to be false
  end

  scenario 'Adding a new proposal close users selection', :not_deterministic do
    proposals.new_proposal('some title')
    proposals.show_form

    expect(proposals.user_selection_is_visible?).to be false
  end
end

def empty_fixture
  visit('/proposals/empty')
end
