require 'rspec'
require 'sinatra'
require 'capybara'
require 'capybara/dsl'

require File.expand_path('../../server.rb', __FILE__)

Sinatra::Application.environment = :test
Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara::DSL
end

describe 'Test environment' do

  it 'WORKS!' do
  end

end
