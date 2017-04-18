module Questions
  class Repository
    class << self
      def store(question, author, proposal_id)
        @contents ||= []
        @contents << Question.new(question, author, proposal_id)
      end

      def retrieve(requested_proposal_id)
        @contents ||= []
        @contents.find { |question| question.proposal_id == requested_proposal_id }
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
      end
    end
  end
end
