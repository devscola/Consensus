module Questions
  class Repository
    class << self
      def store(question)
        @contents ||= []
        @contents << Question.new(
          question['body'],
          question['author'],
          question['proposal_id']
        )
        return nil
      end

      def retrieve(requested_proposal_id)
        @contents ||= []
        @contents.find_all { |question| question.proposal_id == requested_proposal_id }
      end

      private

      class Question
        attr_reader :body, :author, :proposal_id, :date
        def initialize(body, author, proposal_id)
          @body = body
          @author = author
          @proposal_id = proposal_id
          @date = Time.now.utc
        end

        def to_h
          { body: @body, author: @author, date: @date }
        end
      end
    end
  end
end
