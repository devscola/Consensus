require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative 'test_support/discussion_board'
require_relative 'test_support/fixtures'
require_relative '../../app'

feature 'Proposals' do
  before(:each) do
    visit('/proposals/empty')
  end
  let(:proposals) { Page::Proposals.new }

  scenario 'when there are no proposals the list is empty' do

    result = proposals.proposal_amount

    expect(result).to be 0
  end

  scenario 'when there are some proposals the list is not empty' do

    proposals.show_form
    proposals.new_proposal('some title', some_enough_proposal_content)
    proposals.submit_proposal
    sleep 1
    result = proposals.proposal_amount

    expect(result).to be 1
  end

  scenario 'when creating a proposal a form to fill appears' do

    alpha_result = proposals.form_is_visible?
    proposals.new_proposal('some title', 'some content')
    betta_result = proposals.form_is_visible?

    expect(alpha_result).to be false
    expect(betta_result).to be true
  end

  scenario 'when a proposal is created the form disappears' do
    proposals.show_form
    proposals.new_proposal('some title', some_enough_proposal_content)
    result = proposals.form_is_visible?

    expect(result).to be true
  end

end

feature 'New proposal form' do
  let(:proposals) { Page::Proposals.new }

  scenario 'counter shows text area length' do
    some_text = 'some random text'
    character_amount = some_text.length

    proposals.show_form
    proposals.fill_content(some_text)
    result = proposals.content_length

    expect(result.to_i).to eq(character_amount)
  end

  scenario 'submit button activates and deactivates depending on content' do

    proposals.show_form
    alpha_result = proposals.submit_button_enabled?
    proposals.fill_content(some_enough_proposal_content)
    betta_result = proposals.submit_button_enabled?
    proposals.remove_content
    gamma_result = proposals.submit_button_enabled?

    expect(alpha_result).to eq(false)
    expect(betta_result).to eq(true)
    expect(gamma_result).to eq(false)
  end

  scenario 'a info message is shown or hide depending on content' do

    proposals.show_form
    alpha_result = proposals.info_message_visible?
    proposals.fill_content(some_enough_proposal_content)
    betta_result = proposals.info_message_visible?
    proposals.remove_content
    gamma_result = proposals.info_message_visible?

    expect(alpha_result).to eq(true)
    expect(betta_result).to eq(false)
    expect(gamma_result).to eq(true)
  end

  scenario 'when the user click a listed proposal is redirected to that proposal discussion-board' do
    proposals.new_proposal('some random title', some_enough_proposal_content)
    proposals.submit_proposal
    proposals.new_proposal('another random title', some_enough_proposal_content)
    proposals.submit_proposal

    sleep 1

    board = proposals.visit_proposal('some random title')

    a_result = board.proposal_title

    expect(a_result).to eq('some random title')
  end

  feature 'User Circle' do

    scenario 'retrieves user list' do
      proposals.show_form
      proposals.new_proposal('some random title', some_enough_proposal_content)
      proposals.submit_proposal

      result = proposals.user_amount

      expect(result).to be > 0
    end
  end
end

def some_enough_proposal_content
  Fixtures.enough_proposal_content
end
