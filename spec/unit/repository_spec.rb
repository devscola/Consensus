require 'spec_helper_tdd'
require_relative './../../repository'

describe Repository do
  it 'stores an item associated to a unique key' do

    Repository.store(:some_key, :some_item)
    Repository.store(:other_key, :other_item)
    alpha_result = Repository.retrieve(:some_key)
    betta_result = Repository.retrieve(:other_key)

    expect(alpha_result).to be_a(Repository::Credential)
    expect(betta_result).to be_a(Repository::Credential)
  end
end
