require 'mongo'
require_relative '../../support/configuration'

module Proposals
  class Repository
    class << self
      def store(title = '', content, proposer)
        id = generate_id(title.to_s, content.to_s)
        proposal = Proposal.new(id, proposer)
        proposal.attach(title,content)
        save(proposal)
        return proposal
      end

      def save(proposal)
        collection.insert_one(proposal.serialize)
      end

      def update(proposal)
        document = proposal.serialize
        collection.find_one_and_replace({ id: document['id'] }, document)
      end

      def retrieve(id)
        data = collection.find({ id: id }).first
        Proposal.from_bson(data)
      end

      def all
        proposals_data = collection.find()
        proposals_data.map { |data| Proposals::Proposal.from_bson(data) }
      end

      def empty
        collection.delete_many()
      end

      private

      def generate_id(*identifiers)
        Digest::MD5.hexdigest(identifiers.join)
      end

      def connection
        @connection ||= Mongo::Client.new(
          ["#{host}:27017"],
          :database => 'consensus_db'
        )
      end

      def collection
        connection[:proposals]
      end

      def host
        Support::Configuration.host
      end
    end
  end
end
