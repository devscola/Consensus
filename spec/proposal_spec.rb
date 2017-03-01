require 'spec_helper'
require_relative 'test_support/proposal'
require_relative '../app'

feature 'New proposal page' do
  scenario 'counter shows text area length' do
    proposal = Page::Proposal.new
    some_text = 'some random text'
    character_amount = some_text.length
    
    proposal.fill_content(some_text)
    result = proposal.content_length

    expect(result.to_i).to eq(character_amount)
  end

  scenario 'submit button activates and deactivates depending on content' do
    proposal = Page::Proposal.new
    some_content = '*' * 1000

    alpha_result = proposal.submit_button_enabled?
    proposal.fill_content(some_content)
    betta_result = proposal.submit_button_enabled?
    proposal.remove_content
    gamma_result = proposal.submit_button_enabled?

    expect(alpha_result).to eq(false)
    expect(betta_result).to eq(true)
    expect(gamma_result).to eq(false)
  end
end
