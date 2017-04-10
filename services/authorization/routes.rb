require 'sinatra/base'
require 'json'
require_relative './service'

class App < Sinatra::Base
  post '/login' do
    payload = JSON.parse(request.body.read)
    username = payload['username']
    password = payload['password']

    token = Authorization::Service.verify(username, password)
    { token: token }.to_json
  end
end
