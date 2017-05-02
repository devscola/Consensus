module Questions
  class Question < Domain::Question
    def self.from_bson(data)
      question = Questions::Question.new(
          data['content'],
          data['author'],
          data['proposal_id']
        )
    end

    def self.from_json(data)
      question = Questions::Question.new(
          data['content'],
          data['author'],
          data['proposal_id']
        )
    end

    def serialize
      {
        'content' => @content,
        'author' => @author,
        'proposal_id' => @proposal_id,
        'date' => @date
      }
    end
  end
end
