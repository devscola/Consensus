require 'spec_helper_tdd'
require_relative './../../services/questions/repository'

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

  it 'stores questions' do
    question_data = {
      'content' => :some_question,
      'author' => :some_author,
      'proposal_id' => :some_proposal_id
    }

    question = Questions::Question.from_json(question_data)

    Questions::TestRepository.store(question)
    questions = Questions::TestRepository.retrieve(:some_proposal_id)
    question = questions.first
    result = question.serialize

    expect(result['content']).to be(:some_question)
    expect(result['date']).to be_truthy
    expect(result['author']).to be(:some_author)
  end

  it 'delivers nothing when there are no questions related to a proposal' do
    result = Questions::TestRepository.retrieve(:another_proposal_id)

    expect(result).to eq([])
  end
end
