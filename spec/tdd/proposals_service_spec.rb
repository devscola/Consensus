require 'spec_helper_tdd'
require 'digest/md5'
require_relative './../../services/proposals/service'

describe Proposals::Service do
  before(:each) do
    Proposals::Service.empty
  end

  it 'return empty when no proposals' do
    result = Proposals::Service.list()

    expect(result).to eq([])
  end

  it 'returns proposals added' do
		Proposals::Service.add(:title, :content)
  	Proposals::Service.add(:title, :content)

    result = Proposals::Service.list()

    expect(result.size).to eq 2
  end

  it 'returns proposal added contents' do
  	Proposals::Service.add(:a_title, :content)

    result = Proposals::Service.list()
    the_proposal = result.last
    expect(the_proposal[:title]).to eq :a_title
  end

  it 'retrieve a scenario via search' do
    id = Proposals::Service.add('title_sample', 'content_sample')
    Proposals::Service.add('not_what_you_re_looking_for', 'content_sample')

    result = Proposals::Service.retrieve(id)
    expect(result.to_h[:id]).to eq id
    expect(result.to_h[:title]).to eq 'title_sample'
    expect(result.to_h[:content]).to eq 'content_sample'
  end

  it 'retrieves proposals with its identifiers' do
    some_proposal_title = 'some title'
    some_proposal_content = 'some content'
    Proposals::Service.add(some_proposal_title, some_proposal_content)

    retrieval_code = calculate_proposal_signature(some_proposal_title, some_proposal_content)
    result = Proposals::Service.retrieve(retrieval_code)

    expect(result.to_h[:title]).to eq('some title')
    expect(result.to_h[:content]).to eq('some content')
  end

  it 'adds users to a proposal circle' do
    some_proposal_title = 'some title'
    some_proposal_content = 'some content'
    username = 'KingRobert'
    Proposals::Service.add(some_proposal_title, some_proposal_content)
    retrieval_code = calculate_proposal_signature(some_proposal_title, some_proposal_content)
    Proposals::Service.involve(retrieval_code, username)

    result = Proposals::Service.involved(retrieval_code)

    expect(result[:circle]).to eq(['KingRobert'])
  end

  it 'retrieves proposal with its circle' do
    some_proposal_title = 'some title'
    some_proposal_content = 'some content'
    first_user = 'KingRobert'
    second_user = 'Cersei'
    Proposals::Service.add(some_proposal_title, some_proposal_content)
    retrieval_code = calculate_proposal_signature(some_proposal_title,
                                                  some_proposal_content)
    Proposals::Service.involve(retrieval_code, first_user)
    Proposals::Service.involve(retrieval_code, second_user)

    result = Proposals::Service.retrieve(retrieval_code)

    expect(result.to_h[:circle]).to eq(['KingRobert', 'Cersei'])
  end

  def calculate_proposal_signature(title, content)
    proposal_signature = title + content
    retrieval_code = Digest::MD5.hexdigest(proposal_signature)
  end
end
