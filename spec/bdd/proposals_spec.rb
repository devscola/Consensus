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
    result = proposals.exist_proposal

    expect(result).to be false
  end

  scenario 'when there are some proposals the list is not empty' do
    proposals.show_form
    proposals.new_proposal('some title', some_enough_proposal_content)

    result = proposals.exist_proposal

    expect(result).to be true
  end

  scenario 'when creating a proposal a form to fill appears' do
    alpha_result = proposals.form_visible?
    proposals.show_form
    betta_result = proposals.form_visible?

    expect(alpha_result).to be false
    expect(betta_result).to be true
  end

  scenario 'when a proposal is created the form disappears' do
    proposals.show_form
    proposals.new_proposal('some title', some_enough_proposal_content)

    result = proposals.form_visible?

    expect(result).to be false
  end

  scenario 'when a proposal is created appears the user selection' do
    proposals.show_form

    previous_result = proposals.user_selection_is_visible?
    proposals.new_proposal('some title', some_enough_proposal_content)
    actual_result = proposals.user_selection_is_visible?

    expect(previous_result).to be false
    expect(actual_result).to be true
  end

  scenario 'when proposal is created display list alphabetical users' do
    proposals.show_form

    proposals.new_proposal('some title', some_enough_proposal_content)
    list_users = proposals.user_list_is_visible?

    expect(list_users).to be true
  end
end

feature 'New proposal form' do
  before(:each) do
    visit('/proposals/empty')
  end
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
    proposals.new_proposal('first random title', some_enough_proposal_content)
    proposals.new_proposal('another random title', some_enough_proposal_content)

    board = proposals.visit_proposal('first random title')

    a_result = board.proposal_title

    expect(a_result).to eq('first random title')
  end
end

feature 'Create circle' do
  before(:each) do
    visit('/proposals/empty')
  end
  let(:proposals) { Page::Proposals.new }

  scenario 'retrieves users' do
    proposals.show_form
    proposals.new_proposal('second random title', some_enough_proposal_content)

    result = proposals.user_amount

    expect(result).to be > 0
  end

  scenario 'changes user button to symbol' do
    proposals.show_form
    proposals.new_proposal('third random title', some_enough_proposal_content)
    proposals.click_user_button('Cersei')

    result = proposals.symbol_exists?('Cersei')

    expect(result).to be true
  end

  scenario 'button finish proposal is disabled when list has not changes' do
    proposals.show_form

    proposals.new_proposal('some random test circle title', some_enough_proposal_content)
    result = proposals.button_finish_activate?

    expect(result).to be false
  end

  scenario 'button finish proposal is enabled when list has changes' do
    proposals.show_form

    proposals.new_proposal('some random test circle title', some_enough_proposal_content)
    proposals.click_user_button('Cersei')
    result = proposals.button_finish_activate?

    expect(result).to be true
  end

  scenario 'button finish closes userList' do
    proposals.show_form

    proposals.new_proposal('some random test circle title', some_enough_proposal_content)
    proposals.click_user_button('Cersei')
    proposals.button_finish_click

    result = proposals.user_selection_is_visible?

    expect(result). to be false
  end

  scenario 'button New Proposal closes userList' do
    proposals.show_form

    proposals.new_proposal('some random test new proposal button', some_enough_proposal_content)
    proposals.do_show_form

    result = proposals.user_selection_is_visible?

    expect(result). to be false
  end

end

def some_enough_proposal_content
  Fixtures.enough_proposal_content
end
