require_relative 'repository'

module Proposals
  class Service
    class << self
      def add(title, content)
        id = Repository.store(title, content)
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

      def user_inside_circle(idProposal, username)
        circle = retrieve(idProposal)[:circle]

        validUsername = circle.find_index(username)

        return validUsername != nil
      end
    end
  end
end
