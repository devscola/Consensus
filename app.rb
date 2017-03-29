require 'sinatra/base'
require_relative './services/authorization/routes'
require_relative './services/proposals/routes'

class App < Sinatra::Base
  set :public_folder, './public/'

  get '/' do
    File.read(File.join('public', 'proposals.html'))
  end

  get '/proposals' do
    File.read(File.join('public', 'proposals.html'))
  end

  get '/discussion-board/*' do
    File.read(File.join('public', 'discussion-board.html'))
  end

  get '/login' do
    File.read(File.join('public', 'login.html'))
  end
end
