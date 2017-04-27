require 'mongo'

module Proposals
  class Repository
   
    class << self
      def store(title = '', content, proposer)
        id = generate_id(title.to_s, content.to_s)
        proposal = Proposal.new(title, content, id, proposer)
        save(proposal)
        return proposal.to_h
      end

      def save(proposal)
        client = Mongo::Client.new([ 'mongocontainer:27017' ],
         :database => 'consensus_db')
        collection = client[:proposals]
        collection.insert_one(proposal.to_h)
      end

      def retrieve(id)
        client = Mongo::Client.new([ 'mongocontainer:27017' ],
        :database => 'consensus_db')
        collection = client[:proposals]
        collection.find({id: id}).first
      end

      def all
        client = Mongo::Client.new([ 'mongocontainer:27017' ],
         :database => 'consensus_db')
        collection = client[:proposals]
        collection.find()
      end

      def empty
        client = Mongo::Client.new([ 'mongocontainer:27017' ],
         :database => 'consensus_db')
        collection = client[:proposals]
        collection.delete_many()
      end

      private

      def generate_id(*identifiers)
        Digest::MD5.hexdigest(identifiers.join)
      end

      class Proposal
        attr_reader :id, :title, :proposer, :content, :circle

        def initialize(title, content, id, proposer)
          @title = title
          @content = content
          @id = id
          @proposer = proposer
          @circle = [proposer]
        end

        def to_h
          { title: @title, content: @content, proposer: @proposer, id: @id, circle: @circle }
        end
      end
    end
  end
end
