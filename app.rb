require 'json'
require 'sinatra/base'
require_relative './services/authorization_service'
require_relative './services/proposal_service'

class App < Sinatra::Base

  class ProposalReminder
    attr_accessor :title, :content
  end

  reminder = ProposalReminder.new

  set :static, true
  set :public_folder, './public/'

  get '/' do
    File.read(File.join('public', 'index.html'))
  end

  get '/proposals' do
    File.read(File.join('public', 'proposals.html'))
  end

  post '/proposals/add' do
    payload = JSON.parse(request.body.read)
    title = payload['title']
    content = payload['content']

    result = ProposalService.add(title, content)
    result.to_json
  end

  get '/proposal' do
    File.read(File.join('public', 'proposal.html'))
  end

  post '/proposal' do
    reminder.title = params[:proposal_title]
    reminder.content = params[:proposal_content]
    redirect to('/discussion-board')
  end

  get '/list' do
    File.read(File.join('public', 'list.html'))
  end

  post '/login' do
    payload = JSON.parse(request.body.read)
    username = payload['username']
    password = payload['password']

    verified = AuthorizationService.verify(username, password)
    {valid: verified}.to_json
  end
end
