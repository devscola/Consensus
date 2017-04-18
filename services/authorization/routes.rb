require 'sinatra/base'
require 'json'
require_relative './service'

class App < Sinatra::Base
  post '/login' do
    payload = JSON.parse(request.body.read)
    username = payload['username']
    password = payload['password']

    response = Authorization::Service.verify(username, password)

    if response
      { valid: true, token: response }.to_json
    else
      { valid: false }.to_json
    end
  end

  post '/user/logged' do
    payload = JSON.parse(request.body.read)
    token = payload['token']

    username = Authorization::Service.decode(token)

    { 'username': username }.to_json
  end

  post '/create-proposal/token' do
    payload = JSON.parse(request.body.read)
    token = payload['token']

    response = Authorization::Service.decode_token(token)

    { 'token': response.md5 }.to_json
  end

end
