module Proposals
  class Repository
    @proposals = []

    class << self
      def store(title = '', content)
        id = generate_id(title.to_s, content.to_s)
        @proposals << Proposal.new(title, content, id)
        return id
      end

      def retrieve(id)
        @proposals.find { |proposal| proposal.id == id }
      end

      def all
        @proposals
      end

      def empty
        @proposals = []
      end

      private

      def generate_id(*identifiers)
        Digest::MD5.hexdigest(identifiers.join)
      end

      class Proposal
        attr_reader :id, :title, :content, :circle

        def initialize(title, content, id, circle = [])
          @title = title
          @content = content
          @id = id
          @circle = circle
        end

        def to_h
          { title: @title, content: @content, id: @id, circle: @circle }
        end
      end
    end
  end
end
