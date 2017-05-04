require 'spec_helper_tdd'
require_relative './../../system/questions/service'

describe Questions::Service do
  before(:each) do
    Questions::Service.flush
  end

  it 'stores questions' do
    question_data = {
      'content' => :some_question,
      'author' => :some_author,
      'proposal_id' => :some_proposal_id
    }

    Questions::Service.store(question_data)
    questions = Questions::Service.retrieve(:some_proposal_id)
    result = questions.first

    expect(result['content']).to be(:some_question)
    expect(result['date']).to be_truthy
    expect(result['author']).to be(:some_author)
  end

  it 'delivers nothing when there are no questions related to a proposal' do
    result = Questions::Service.retrieve(:some_proposal_id)

    expect(result).to eq([])
  end
end
