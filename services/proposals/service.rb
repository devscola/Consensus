require 'digest/md5'

module Proposals
  class Service
    def self.add(title, content)
      generated_id = self.generate_id(title.to_s, content.to_s)
  		@proposals ||= []
      @proposals << Proposal.new(title, content, generated_id)
      generated_id
    end

    def self.list()
    	@proposals ||= []
      serialized = @proposals.map do |proposal|
      	proposal.to_h
      end
      serialized
    end

    def self.empty
      @proposals = []
    end

    def self.retrieve(id)
      result = find_proposal(id)
      result.to_h
    end

    def self.involve(id, username)
      proposal = find_proposal(id)
      proposal.circle << username
      ''
    end

    def self.involved(id)
      proposal = find_proposal(id)
      {'circle': proposal.circle}
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

    private

    def self.generate_id(*identifiers)
      Digest::MD5.hexdigest( identifiers.join.to_s )
    end

    def self.find_proposal(id)
      @proposals.find { |proposal| proposal.id == id }
    end

  end
end
