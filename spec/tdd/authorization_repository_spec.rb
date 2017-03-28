require 'spec_helper_tdd'
require_relative './../../services/authorization/repository'

describe Authorization::Repository do
  it 'stores an item associated to a unique key' do
    Authorization::Repository.store(:some_key, :some_item)
    Authorization::Repository.store(:other_key, :other_item)
    alpha_result = Authorization::Repository.retrieve(:some_key)
    betta_result = Authorization::Repository.retrieve(:other_key)

    expect(alpha_result).to be_a(Authorization::Repository::Credential)
    expect(betta_result).to be_a(Authorization::Repository::Credential)
  end
end
