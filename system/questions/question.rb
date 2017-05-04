module Questions
  class Question < Domain::Question
    class << self
      def from_bson(data)
        Questions::Question.new(
          data['content'],
          data['author'],
          data['proposal_id']
        )
      end

      alias_method :from_json, :from_bson
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
