module Questions
  class Repository
    class << self
      def store(question)
        @contents ||= []
        @contents << Question.new(
          question['content'],
          question['author'],
          question['proposal_id']
        )
        return nil
      end

      def retrieve(requested_proposal_id)
        @contents ||= []
        @contents.find_all do |question|
          question.proposal_id == requested_proposal_id
        end
      end
    end
  end
end
