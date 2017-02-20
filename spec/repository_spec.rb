require 'spec_helper'
require_relative './../repository'

describe Repository do
  it 'stores an item associated to a unique key' do
    repository = Repository.new

    repository.store(:some_key, :some_item)
    result = repository.retrieve(:some_key)

    expect(result).to be(:some_item)
  end
end
