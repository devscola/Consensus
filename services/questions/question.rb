module Questions
  class Question < Domain::Question
    attr_reader :content, :date, :author, :proposal_id
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
