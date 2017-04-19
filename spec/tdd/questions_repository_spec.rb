require 'spec_helper_tdd'
require_relative './../../services/proposals/questions_repository'

module Proposals
  class TestRepository < QuestionsRepository
    def self.flush
      @contents = []
    end
  end
end

describe Proposals::QuestionsRepository do
  before(:each) do
    Proposals::TestRepository.flush
  end

  it 'stores questions related to a proposal' do
    Proposals::TestRepository.store(:some_question, :some_author, :some_proposal_id)
    result = Proposals::TestRepository.retrieve(:some_proposal_id)

    expect(result.body).to be(:some_question)
    expect(result.date).to be_truthy
    expect(result.author).to be(:some_author)
  end

  it 'delivers nothing when there are no questions related to a proposal' do
    result = Proposals::TestRepository.retrieve(:some_proposal_id)

    expect(result).to be(nil)
  end
end
