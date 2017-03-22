require 'json'
require 'sinatra/base'
require_relative './services/authorization/service'
require_relative './services/proposals/service'

class App < Sinatra::Base

  get '/' do
    File.read(File.join('public', 'proposals.html'))
  end

  get '/proposals' do
    File.read(File.join('public', 'proposals.html'))
  end

  post '/proposals/add' do
    payload = JSON.parse(request.body.read)
    title = payload['title']
    content = payload['content']

    result = Proposals::Service.add(title, content)
    result.to_json
  end

  post '/proposals/list' do
    result = Proposals::Service.list()
    {result: result}.to_json
  end

  get '/proposals/empty' do
    Proposals::Service.empty
  end

  post '/proposals/retrieve' do
    body = JSON.parse(request.body.read)
    id = body['proposal_id']

    result = Proposals::Service.retrieve(id)
    result.to_json
  end

  post '/proposal/user/add' do
    body = JSON.parse(request.body.read)
    id = body['id']
    username = body['username']
    result = Proposals::Service.involve(id, username)
    result.to_json
  end

  post '/proposal/users/retrieve' do
    body = JSON.parse(request.body.read)
    id = body['id']
    result = Proposals::Service.involved(id)
    result.to_json
  end

  post '/proposal/circle' do
    result = Authorization::Service.users
    result.to_json
  end

  get '/discussion-board/*' do
    File.read(File.join('public', 'discussion-board.html'))
  end

  get '/login' do
    File.read(File.join('public', 'login.html'))
  end

  post '/login' do
    payload = JSON.parse(request.body.read)
    username = payload['username']
    password = payload['password']

    verified = Authorization::Service.verify(username, password)
    {valid: verified}.to_json
  end
end
