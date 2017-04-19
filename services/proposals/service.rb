require_relative 'repository'
require_relative 'questions_repository'

module Proposals
  class Service
    class << self
      def add(title, content, proposer)
        id = Repository.store(title, content, proposer)
        return id
      end

      def list()
        Repository.all.map { |proposal| proposal.to_h }
      end

      def empty
        Repository.empty
      end

      def retrieve(id)
        proposal = Repository.retrieve(id).to_h
        questions = QuestionsRepository.retrieve(id).map { |question| question.to_h }
        proposal['questions'] = questions
        proposal
      end

      def involve(id, username)
        proposal = Repository.retrieve(id)
        proposal.circle << username
        ''
      end

      def involved(id)
        proposal = Repository.retrieve(id)
        { 'circle': proposal.circle }
      end

      def user_inside_circle?(id, username)
        circle = retrieve(id)[:circle]

        circle.include?(username)
      end

      def add_question(question)
        Proposals::QuestionsRepository.store(question)
      end
    end
  end
end
