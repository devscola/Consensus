require 'spec_helper_tdd'
require_relative './../../services/proposals_service'

describe ProposalsService do
	before(:each) do
		ProposalsService.empty
	end

  it 'return empty when no proposals' do
    result = ProposalsService.list()

    expect(result).to eq([])
  end

  it 'returns proposals added' do
		ProposalsService.add(:title, :content)
  	ProposalsService.add(:title, :content)

    result = ProposalsService.list()

    expect(result.size).to eq 2
  end

  it 'returns proposal added contents' do
  	ProposalsService.add(:a_title, :content)

    result = ProposalsService.list()
    the_proposal = result.last
    expect(the_proposal[:title]).to eq :a_title
  end

  it 'retrieve a scenario via search' do
    id = ProposalsService.add('title_sample', 'content_sample')
    ProposalsService.add('not_what_you_re_looking_for', 'content_sample')

    result = ProposalsService.retrieve(id)
    expect(result.to_h[:id]).to eq id
    expect(result.to_h[:title]).to eq 'title_sample'
    expect(result.to_h[:content]).to eq 'content_sample'
  end
end