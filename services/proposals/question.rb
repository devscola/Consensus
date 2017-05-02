module Proposals
  class Question < Domain::Question
    def self.from_bson(bson)
      the_question = Proposals::Question::Question.new(
        bson['body'],
        bson['author'],
        bson['proposal_id']
      )
      the_question
    end

    def serialize
      {
        body: @body,
        author: @author,
        date: @date
      }
    end
  end
end
