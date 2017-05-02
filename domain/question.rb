module Domain
  class Question
    def initialize(content, author, proposal_id)
      @content = content
      @author = author
      @proposal_id = proposal_id
      @date = Time.now.utc
    end
  end
end
