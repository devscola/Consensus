require 'spec_helper_tdd'
require_relative './../../../services/questions/respository'

module Questions
  class TestRepository < Repository
    def self.flush
      @contents = []
    end
  end
end

describe Questions::Repository do
  before(:each) do
    Questions::TestRepository.flush
  end

  it 'stores questions related to a proposal' do
    Questions::TestRepository.store(:some_question, :some_author, :some_proposal_id)
    result = Questions::TestRepository.retrieve(:some_proposal_id)

    expect(result.body).to be(:some_question)
    expect(result.date).to be_truthy
    expect(result.author).to be(:some_author)
  end

  it 'delivers nothing when there are no questions related to a proposal' do
    result = Questions::TestRepository.retrieve(:some_proposal_id)

    expect(result).to be(nil)
  end
end
