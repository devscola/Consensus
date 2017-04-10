require 'sinatra/base'
require 'json'
require_relative './service'

class App < Sinatra::Base
  post '/login' do
    payload = JSON.parse(request.body.read)
    username = payload['username']
    password = payload['password']

    verified = Authorization::Service.verify(username, password)

    if verified
    	{ valid: verified, token: 'fake token' }.to_json
    else
    	{ valid: verified }.to_json
    end

  end
end