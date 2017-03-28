require 'digest/md5'

module Proposals
  class Service
    class << self
      def add(title, content)
        generated_id = generate_id(title.to_s, content.to_s)
    		@proposals ||= []
        @proposals << Proposal.new(title, content, generated_id)
        generated_id
      end

      def list()
      	@proposals ||= []
        serialized = @proposals.map do |proposal|
        	proposal.to_h
        end
        serialized
      end

      def empty
        @proposals = []
      end

      def retrieve(id)
        result = find_proposal(id)
        result.to_h
      end

      def involve(id, username)
        proposal = find_proposal(id)
        proposal.circle << username
        ''
      end

      def involved(id)
        proposal = find_proposal(id)
        {'circle': proposal.circle}
      end

      private

      def generate_id(*identifiers)
        Digest::MD5.hexdigest( identifiers.join.to_s )
      end

      def find_proposal(id)
        @proposals.find { |proposal| proposal.id == id }
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
