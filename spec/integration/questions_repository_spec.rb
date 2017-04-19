require 'rack/test'
require 'json'
require_relative './../../services/proposals/routes'

describe Proposals::QuestionsRepository do
  include Rack::Test::Methods

  def app
    App.new
  end

  it 'adds question to proposal' do
    pending 'this test is red in the computer of leo and zero'
    proposal_id = add_proposal
    question = {
      body: 'some_text',
      author: 'KingRobert',
      proposal_id: proposal_id
    }.to_json

    post '/proposals/add/question', question
    result = retrieved_proposal

    expect(result[:body]).to eq('some_text')
    expect(result[:author]).to eq('KingRobert')
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
    body = first_question['body']
    author = first_question['author']
    { body: body, author: author }
  end

  def parse_response
    JSON.parse(last_response.body)
  end
end
