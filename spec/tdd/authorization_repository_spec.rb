require 'spec_helper_tdd'
require_relative './../../services/authorization/repository'

describe Authorization::Repository do
  it 'stores a token associated to a unique md5' do
    username = 'KingRobert'
    token = Authorization::Repository.token(username)

    result = Authorization::Repository.retrieve_username(token)

    expect(result).to eq('KingRobert')
  end
end
