require_relative 'repository'

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
        Repository.retrieve(id).to_h
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
    end
  end
end
