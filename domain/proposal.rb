require_relative 'circle'

module Domain
  class Proposal
    def initialize(id, proposer)
      @id = id
      @circle = Circle.new
      @proposer = proposer
      involve(@proposer)
    end

    def attach(title, content)
      @title = title
      @content = content
    end

    def involve(person)
      @circle.involve(person)
    end

    def involved
      @circle.involved
    end

    def involved?(person)
      @circle.involved?(person)
    end
  end
end
