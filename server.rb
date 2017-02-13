require 'sinatra'

set :static, true
set :public_folder, './public/'

get '/' do
  'Hello World'
end
