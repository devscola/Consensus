require 'spec_helper'
require_relative 'test_support/new_proposal_page'
require_relative '../app'

feature "New Proposal Home Page" do
  scenario 'Has required elements' do
    new_proposal_page = Page::NewProposalPage.new

    expect(page).to have_css("#proposal-title")
    expect(page).to have_css("#proposal-content")
    expect(page).to have_css("#proposal-submit")
  end
  scenario 'Input proposal title has placeholder' do
    new_proposal_page = Page::NewProposalPage.new

    result = find('#proposal-title')['placeholder']

    expect(result).to eq("Type your title here. Remember, keep it short and clear")
  end
  scenario 'Input proposal content has placeholder' do
    new_proposal_page = Page::NewProposalPage.new

    result = find('#proposal-content')['placeholder']

    expect(result).to eq("Type your proposal text here. Remember, explain your proposal thoroughly")
  end
end
