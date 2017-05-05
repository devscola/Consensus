require_relative 'question'
require_relative 'repository'
require_relative './../proposals/repository'

module Questions
  class Service
    class << self
      def flush
        Questions::Repository.flush
      end

      def store(question_data)
        question = Questions::Question.from_json(question_data)
        Questions::Repository.store(question)
      end

      def retrieve(proposal_id)
        questions = Questions::Repository.retrieve(proposal_id)
        questions.map { |question| question.serialize }
      end
    end
  end
end
