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

  xscenario 'when creating a proposal a form to fill appears' do
    proposals = Page::Proposals.new

    alpha_result = proposals.form_is_visible?
    proposals.new_proposal('some title', 'some content')
    betta_result = proposals.form_is_visible?

    expect(alpha_result).to be :invisible
    expect(betta_result).to be :visible
  end

  def some_enough_proposal_content
    Fixtures.enough_proposal_content
  end
end
