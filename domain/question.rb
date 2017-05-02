module Domain
  class Question
    def initialize(body, author, proposal_id)
      @body = body
      @author = author
      @proposal_id = proposal_id
      @date = Time.now.utc
    end
  end
end
