require_relative '../../domain/proposal'
require_relative '../../domain/circle'
require_relative 'questions_repository'
require_relative 'repository'
require_relative 'proposal'
require_relative 'circle'

module Proposals
  class Service
    class << self
      def add(title, content, proposer)
        proposal = Repository.store(title, content, proposer)
        return proposal.serialize
      end

      def list()
        all_proposals = Repository.all
        all_proposals.map { |proposal| proposal.serialize }
      end

      def empty
        Repository.empty
      end

      def retrieve(id)
        Repository.retrieve(id).serialize
      end

      def involve(id, username)
        proposal = Repository.retrieve(id)
        proposal.involve(username)
        Repository.update(proposal)
        proposal.serialize
      end

      def involved(id)
        proposal = Repository.retrieve(id)
        { 'circle': proposal.involved }
      end

      def user_inside_circle?(id, username)
        the_proposal = Repository.retrieve(id)
        the_proposal.involved?(username)
      end

      def add_question(question)
        proposal_id = question.fetch('proposal_id')
        Proposals::QuestionsRepository.store(question)

        proposal = Repository.retrieve(proposal_id).serialize
        questions = QuestionsRepository.retrieve(proposal_id).map { |question| question.to_h }
        proposal['questions'] = questions
        proposal
      end
    end
  end
end
