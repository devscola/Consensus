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
    Proposals::Service.add(:title, :content, :some_proposer)
    Proposals::Service.add(:title, :content, :some_proposer)

    result = Proposals::Service.list()

    expect(result.size).to eq 2
  end

  it 'returns proposal added contents' do
    Proposals::Service.add(:some_title, :content, :some_proposer)
    result = Proposals::Service.list()
    the_proposal = result.last
    expect(the_proposal['title']).to eq :some_title
  end

  it 'retrieve a scenario via search' do
    proposal = Proposals::Service.add('title_sample', 'content_sample', :some_proposer)
    Proposals::Service.add('not_what_you_re_looking_for', 'content_sample', :some_proposer)

    result = Proposals::Service.retrieve(proposal['id'])
    expect(result['id']).to eq proposal['id']
    expect(result['title']).to eq 'title_sample'
    expect(result['content']).to eq 'content_sample'
  end

  it 'adds users to a proposal circle' do
    some_proposal_title = 'some title'
    some_proposal_content = 'some content'
    username = 'KingRobert'
    Proposals::Service.add(some_proposal_title, some_proposal_content,:some_proposer)
    retrieval_code = calculate_proposal_signature(some_proposal_title, some_proposal_content)
    Proposals::Service.involve(retrieval_code, username)

    result = Proposals::Service.involved(retrieval_code)

    expect(result[:circle]).to eq([:some_proposer, 'KingRobert'])
  end

  it 'retrieves proposal with its circle' do
    some_proposal_title = 'some title'
    some_proposal_content = 'some content'
    first_user = 'KingRobert'
    second_user = 'Cersei'
    Proposals::Service.add(some_proposal_title, some_proposal_content, :some_proposer)
    retrieval_code = calculate_proposal_signature(some_proposal_title,
      some_proposal_content)
    Proposals::Service.involve(retrieval_code, first_user)
    Proposals::Service.involve(retrieval_code, second_user)

    result = Proposals::Service.retrieve(retrieval_code)

    expect(result['circle']).to eq([:some_proposer, 'KingRobert', 'Cersei'])
  end

  it 'retrieve if user belongs to circle', :wip do
    proposal = Proposals::Service.add('title_sample', 'content_sample', :some_proposer)
    some_person = 'KingRobert'
    another_person = 'Arya'
    Proposals::Service.involve(proposal['id'], some_person)
    Proposals::Service.involve(proposal['id'], another_person)


    result = Proposals::Service.user_inside_circle?(proposal['id'], some_person)

    expect(result).to be true
  end

  it 'stores proposal with its proposer' do
    Proposals::Service.add(:a_title, :content, :some_proposer)
    result = Proposals::Service.list()
    the_proposal = result.last
    expect(the_proposal['proposer']).to eq :some_proposer
  end

  def calculate_proposal_signature(title, content)
    proposal_signature = title + content
    Digest::MD5.hexdigest(proposal_signature)
  end

end
