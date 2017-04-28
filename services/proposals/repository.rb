require 'mongo'

Mongo::Logger.logger.level = ::Logger::INFO

module Proposals
  class Repository
    class << self
      def store(title = '', content, proposer)
        id = generate_id(title.to_s, content.to_s)
        proposal = Proposal.new(id, proposer)
        proposal.attach(title,content)
        save(proposal)
        return proposal.to_h
      end

      def save(proposal)
        collection.insert_one(proposal.to_h)
      end

      def update(proposal)
        document=proposal.to_h
        collection.find_one_and_replace({id: document[:id]},document)
      end

      def retrieve(id)
        data=collection.find({id: id}).first
        Proposal.from_bson(data)
      end

      def all
        collection.find()
      end

      def empty
        collection.delete_many()
      end

      private

      def generate_id(*identifiers)
        Digest::MD5.hexdigest(identifiers.join)
      end

      def connection
        @connection ||= Mongo::Client.new([ 'mongocontainer:27017' ],
                 :database => 'consensus_db')
      end

      def collection
        connection[:proposals]
      end

      class Proposal
        def self.from_bson bson
          the_proposal=Proposal.new(bson['id'],bson['proposer'])
          the_proposal.attach(bson['title'],bson['content'])
          the_proposal.create_circle(bson['circle'])
          the_proposal
        end

        def initialize(id,proposer)
          @id = id
          @circle=[]
          @proposer=proposer
          involve(@proposer)
        end

        def attach(title,content)
          @title = title
          @content = content
        end

        def involve(person)
          return if involved?(person)
          @circle.push(person)
        end

        def involved
          @circle
        end

        def involved? person
          @circle.include?(person)
        end

        def create_circle(a_circle)
          a_circle.each{|person| involve(person)}
        end

        def to_h
          { 'title': @title, 'content': @content, 'proposer': @proposer, 'id': @id, 'circle': @circle }
        end
      end
    end
  end
end
