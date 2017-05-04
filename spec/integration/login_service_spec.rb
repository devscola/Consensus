require 'rack/test'
require 'json'
require_relative './../../system/authorization/routes'

describe 'login service' do
  include Rack::Test::Methods

  def app
    App.new
  end

  it 'retrieves user profile after login' do
    credentials = {
      username: 'Cersei',
      password: 'Lion'
    }.to_json

    post '/login', credentials
    response = JSON.parse(last_response.body)

    expect(response['token']).to be_truthy
    expect(response['username']).to eq('Cersei')
  end
end
