require 'spec_helper'
require_relative 'test_support/new_proposal_page'
require_relative '../app'

feature "New Proposal Home Page" do

  scenario 'Check if title accepts content' do
    new_proposal_page = Page::NewProposalPage.new

    new_proposal_page.fill_title('Random title')
    title_content = new_proposal_page.get_title_value()

    expect(title_content).to eq('Random title')
  end
  
  scenario 'Check if content field accept content' do
    new_proposal_page = Page::NewProposalPage.new

    new_proposal_page.fill_content('Lorem ipsum dolor sit')
    title_content = new_proposal_page.get_content_value()
    
    expect(title_content).to eq('Lorem ipsum dolor sit')
  end
end
