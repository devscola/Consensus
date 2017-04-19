require 'rack/test'
require 'json'
require_relative './../../services/proposals/routes'

describe Proposals::QuestionsRepository do
  include Rack::Test::Methods

  def app
    App.new
  end

  it 'adds question to proposal' do
    payload = {
      'question' => :some_text,
      'author' => 'KingRobert',
      'proposal_id' => :some_id }.to_json

    post '/proposals/add/question', payload
    result = JSON.parse(last_response.body)['added']

    expect(result).to be true
  end
end
