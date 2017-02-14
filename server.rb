require 'sinatra'
require 'json'

set :static, true
set :public_folder, './public/'

LOGIN_CREDENTIALS = [
  {
    :username => 'KingRobert',
    :password => 'Stag'
  },
  {
    :username => 'Cersei',
    :password => 'Lion'
  },
  {
    :username => 'Khaleesi',
    :password => 'Dragon'
  },
  {
    :username => 'Arya',
    :password => 'Wolf'
  },
  {
    :username => 'Varys',
    :password => 'Bird'
  },
  {
    :username => 'Joffrey',
    :password => 'Asshole'
  },
  {
    :username => 'LyanaMormont',
    :password => 'Badass'
  }
]

get '/' do
  'Hello World'
end

post '/login' do
  payload = JSON.parse(request.body.read)
  username = payload['username']
  password = payload['password']

  {valid: valid_user?(username, password)}.to_json
end

def valid_user?(username, password)
  credentials = LOGIN_CREDENTIALS.find { |credentials| credentials[:username] == username }

  return false if credentials.nil?

  credentials[:password] == password
end

