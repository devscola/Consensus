require 'json'
require 'sinatra'
require_relative 'authorization_service'

class ProposalReminder
  attr_accessor :title, :content
end

reminder = ProposalReminder.new

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

post '/proposal' do
  reminder.title = params[:proposal_title]
  reminder.content = params[:proposal_content]
  redirect to('/discussion-board')
end

get '/discussion-board' do
  @title = 'Discussion Board'
  @proposal_title = reminder.title
  @proposal_content = reminder.content
  erb :discussion_board
end

post '/login' do
  payload = JSON.parse(request.body.read)
  username = payload['username']
  password = payload['password']

  verified = AuthorizationService.verify(username, password)
  {valid: verified}.to_json
end
