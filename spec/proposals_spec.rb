require 'spec_helper'
require_relative 'test_support/proposals'
require_relative 'fixtures'
require_relative '../app'

feature 'Proposals' do
  scenario 'when there are no proposals the list is empty' do
    proposals = Page::Proposals.new

    result = proposals.list

    expect(result).to be_empty
  end

  xscenario 'when there are some proposals the list is not empty' do
    proposals = Page::Proposals.new

    proposals.new_proposal('some title', some_enough_proposal_content)
    page.visit('/proposals')
    result = proposals.list

    expect(result).to_not be_empty
  end

  scenario 'when a new proposal is created redirects to discussion' do
    proposals = Page::Proposals.new

    proposals.new_proposal('some title', 'some content')
    url = page.current_url
    result = url.include?('new-proposal.html')

    expect(result).to be true
  end

  def some_enough_proposal_content
    Fixtures.enough_proposal_content
  end
end
