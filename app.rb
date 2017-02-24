require 'json'
require 'sinatra'
require_relative 'authorization_service'

set :static, true
set :public_folder, './public/'

get '/' do
  'Hello World'
end

post '/login' do
  payload = JSON.parse(request.body.read)
  username = payload['username']
  password = payload['password']

  verified = AuthorizationService.verify(username, password)
  {valid: verified}.to_json
end
