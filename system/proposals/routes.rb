require 'sinatra/base'
require_relative './service'
require_relative './../questions/service'

class App < Sinatra::Base
  post '/proposal/users' do
    result = Authorization::Service.users
    result.to_json
  end

  post '/proposals/add' do
    payload = JSON.parse(request.body.read)
    title = payload['title']
    content = payload['content']
    proposer = payload['proposer']

    proposal = Proposals::Service.add(title, content, proposer)
    proposal.to_json
  end

  post '/proposals/list' do
    result = Proposals::Service.list()
    { result: result }.to_json
  end

  get '/proposals/empty' do
    Proposals::Service.flush
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

  # post '/proposals/user/involved' do
  #   body = JSON.parse(request.body.read)
  #   id = body['id']
  #   token = body['token']

  #   username = Authorization::Service.decode(token)

  #   user_is_involved = Proposals::Service.user_inside_circle?(id, username)

  #   result = { 'valid': user_is_involved }
  #   result.to_json
  # end

  post '/proposal/add/question' do
    question = JSON.parse(request.body.read)
    proposal_id = question['proposal_id']

    Questions::Service.store(question)
    questions = Questions::Service.retrieve(proposal_id)
    proposal = Proposals::Service.retrieve(proposal_id)

    proposal['questions'] = questions
    return proposal.to_json
  end
end
