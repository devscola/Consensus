require 'rack/test'
require 'json'
require_relative './../../services/proposals/routes'

describe Proposals::QuestionsRepository do
  include Rack::Test::Methods

  def app
    App.new
  end

  it 'adds question to proposal' do
    proposal_id = add_proposal
    question = {
      body: 'some_text',
      author: 'KingRobert',
      proposal_id: proposal_id
    }.to_json

    post '/proposals/add/question', question

    retrieved_question = retrieve_question(proposal_id)
    expect(retrieved_question[:body]).to eq('some_text')
    expect(retrieved_question[:author]).to eq('KingRobert')
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

  def retrieve_question(proposal_id)
    payload = { 'proposal_id' => proposal_id }.to_json
    post '/proposals/retrieve', payload

    first_question = parse_response['questions'].first
    body = first_question['body']
    author = first_question['author']
    { body: body, author: author }
  end

  def parse_response
    JSON.parse(last_response.body)
  end
end
