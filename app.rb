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

  return {valid: false}.to_json if [username, password].include?(nil)
  {valid: AuthorizationService.verify(username: username, password: password)}.to_json
end
