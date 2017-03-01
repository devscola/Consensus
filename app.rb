require 'json'
require 'sinatra'
require_relative 'authorization_service'

set :static, true
set :public_folder, './public/'
set :views, './views/'

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/proposal' do
  @title = 'New Proposal'
  erb :proposal
end

post '/login' do
  payload = JSON.parse(request.body.read)
  username = payload['username']
  password = payload['password']

  verified = AuthorizationService.verify(username, password)
  {valid: verified}.to_json
end
