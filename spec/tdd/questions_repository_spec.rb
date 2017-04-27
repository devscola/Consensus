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

  it 'stores questions' do
    question = {
      'body' => :some_question,
      'author' => :some_author,
      'proposal_id' => :some_proposal_id
    }
    
    Proposals::TestRepository.store(question)
    result = Proposals::TestRepository.retrieve(:some_proposal_id)

    expect(result.first.body).to be(:some_question)
    expect(result.first.date).to be_truthy
    expect(result.first.author).to be(:some_author)
  end

  it 'delivers nothing when there are no questions related to a proposal' do
    result = Proposals::TestRepository.retrieve(:some_proposal_id)

    expect(result).to eq([])
  end
end
