require 'spec_helper_bdd'
require_relative 'test_support/proposals'
require_relative 'fixtures'
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

    expect(alpha_result).to be :invisible
    expect(betta_result).to be :visible
  end

  scenario 'each item inside the proposal list has an identifier' do
    proposals.new_proposal('some title', some_enough_proposal_content)
    proposals.submit_proposal
    proposals.new_proposal('some another title', some_enough_proposal_content)
    proposals.submit_proposal
    sleep 0.5

    alpha_result = proposals.entries[0]
    betta_result = proposals.entries[1]

    expect(alpha_result[:identifier]).to eq('0')
    expect(betta_result[:identifier]).to eq('1')
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
    proposals.new_proposal('some-random-title', some_enough_proposal_content)
    proposals.submit_proposal
     
    sleep 1
    proposals.visit_first_proposal
    result = page.current_url
     
    expect(result.include?('/proposals/some-random-title')).to be true
  end

  xscenario 'when the user click a listed proposal is redirected to that proposal discussion-board' do
    proposals.new_proposal('some ramdon title', some_enough_proposal_content)

    proposals.go_to_first
    proposal = page
    result = proposal.current_path

    expect(result).to eq('/proposals/som')
  end

end

def some_enough_proposal_content
  Fixtures.enough_proposal_content
end
