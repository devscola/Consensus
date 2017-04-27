require_relative 'repository'
require_relative 'questions_repository'

module Proposals
  class Service
    class << self
      def add(title, content, proposer)
        proposal = Repository.store(title, content, proposer)
        return proposal
      end

      def list()
        Repository.all.map { |proposal| proposal.to_h }
      end

      def empty
        Repository.empty
      end

      def retrieve(id)
        Repository.retrieve(id).to_h
      end

      def involve(id, username)
        proposal = Repository.retrieve(id)

        proposal.circle << username unless user_inside_circle?(id, username)

        proposal.to_h
      end

      def involved(id)
        proposal = Repository.retrieve(id)
        { 'circle': proposal.circle }
      end

      def user_inside_circle?(id, username)
        circle = retrieve(id)['circle']

        circle.include?(username)
      end

      def add_question(question)
        proposal_id = question.fetch('proposal_id')
        Proposals::QuestionsRepository.store(question)

        proposal = Repository.retrieve(proposal_id).to_h
        questions = QuestionsRepository.retrieve(proposal_id).map { |question| question.to_h }
        proposal['questions'] = questions
        proposal
      end
    end
  end
end
