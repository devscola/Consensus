require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative 'test_support/discussion_board'
require_relative 'test_support/fixtures'
require_relative '../../app'

feature 'Proposals' do
  let(:proposals) { Page::Proposals.new }

  scenario 'List is empty before adding proposals' do
    empty_fixture
    expect(proposals.any_proposal?).to be false
  end

  scenario 'Lists proposals added', :wip do
    proposals.new_proposal('some title')
    expect(proposals.any_proposal?).to be true
  end

  scenario 'Form appears when triggered' do
    previous = proposals.form_visible?
    proposals.show_form

    expect(previous).to be false
    expect(proposals.form_visible?).to be true
  end

  scenario 'Form disappears at proposal creation' do
    proposals.new_proposal('some title')
    expect(proposals.form_visible?).to be false
  end

  scenario 'User selection appears after proposal creation' do
    proposals.new_proposal('some title')

    expect(proposals.user_selection_is_visible?).to be true
  end

  xscenario 'Lists users at selection' do
  end

  def empty_fixture
    visit('/proposals/empty')
  end
end

feature 'New proposal form' do
  let(:proposals) { Page::Proposals.new }

  scenario 'Counts number of characters' do
    some_text = 'some random text'
    character_amount = some_text.length

    proposals.show_form
    proposals.fill_content(some_text)

    expect(proposals.content_length).to eq(character_amount)
  end

  scenario 'Toggles button on content length' do
    proposals.show_form
    proposals.fill_content(some_enough_proposal_content)

    enough = proposals.submit_button_enabled?
    proposals.remove_content

    expect(enough).to eq(true)
    expect(proposals.submit_button_enabled?).to eq(false)
  end

  scenario 'Toggles message on content length' do
    proposals.show_form
    proposals.fill_content(some_enough_proposal_content)

    shown = proposals.info_message_visible?
    proposals.remove_content

    expect(shown).to eq(false)
    expect(proposals.info_message_visible?).to eq(true)
  end

  scenario 'Links proposals to the discussion board' do
    the_proposal = 'The Proposal'
    proposals.new_proposal(the_proposal)
    proposals.new_proposal('some title')

    board = proposals.visit_proposal(the_proposal)

    expect(board.proposal_title).to eq(the_proposal)
  end
end

feature 'Create circle' do
  let(:proposals) { Page::Proposals.new }

  scenario 'Shows users of the system' do
    proposals.new_proposal('second random title')
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

  scenario 'Finishing enabled when user added' do
    proposals.new_proposal('some title')
    proposals.click_user_button('Cersei')
    expect(proposals.button_finish_deactivated?).to be false
  end

  scenario 'Finishing closes users selection' do
    proposals.new_proposal('some title')
    proposals.click_user_button('Cersei')

    proposals.button_finish_click

    expect(proposals.user_selection_is_visible?).to be false
  end

  scenario 'Adding a new proposal close users selection' do
    proposals.new_proposal('some random test new proposal button')
    proposals.show_form

    expect(proposals.user_selection_is_visible?).to be false
  end
end

def some_enough_proposal_content
  Fixtures.enough_proposal_content
end
