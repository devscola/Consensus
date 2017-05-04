module Proposals
  class Proposal < Domain::Proposal
    def self.from_bson(bson)
      the_proposal = Proposals::Proposal.new(bson['id'], bson['proposer'])
      the_proposal.attach(bson['title'], bson['content'])
      the_proposal.create_circle(bson['circle'])
      the_proposal
    end

    def serialize
      {
        'title' => @title,
        'content' => @content,
        'proposer' => @proposer,
        'id' => @id,
        'circle' => involved
      }
    end

    def create_circle(a_circle)
      @circle = Proposals::Circle.from_bson(a_circle)
    end
  end
end
