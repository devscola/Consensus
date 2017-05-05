require 'rack/test'
require 'json'
require_relative './../../system/proposals/routes'

describe 'Proposals controller' do
  include Rack::Test::Methods

  def app
    App.new
  end

  it 'retrieves all users' do
    post '/proposal/users'
    result = parse_response

    expect(result).to be_truthy
  end

  it 'adds question to proposal' do
    proposal = add_proposal
    question = {
      content: 'some_text',
      author: 'KingRobert',
      proposal_id: proposal['id']
    }.to_json

    post '/proposals/add/question', question
    result = retrieved_proposal

    expect(result[:content]).to eq('some_text')
    expect(result[:author]).to eq('KingRobert')
  end

  it 'cannot add a user to a proposal circle twice' do
    proposal = add_proposal

    first_result = add_user_to_circle(proposal['id'], 'Cersei')
    second_result = add_user_to_circle(proposal['id'], 'Cersei')

    expect(second_result).to eq(first_result)
  end

  def add_user_to_circle(proposal_id, username)
    payload = {
      id: proposal_id,
      username: username
    }.to_json

    post '/proposal/user/add', payload
    parse_response['circle']
  end

  def add_proposal
    proposal = {
      title: :some_title,
      content: :some_content,
      proposer: :proposer
    }.to_json
    post '/proposals/add', proposal
    parse_response
  end

  def retrieved_proposal
    first_question = parse_response['questions'].first
    content = first_question['content']
    author = first_question['author']
    { content: content, author: author }
  end

  def parse_response
    JSON.parse(last_response.body)
  end
end
