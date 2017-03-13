class ProposalsService
  def self.add(title, content)
		@proposals ||= retrieve_data
    @proposals << Proposal.new(title, content)
    ''
  end

  def self.list()
  	@proposals ||= retrieve_data
    serialized=@proposals.map do |proposal| 
    	proposal.to_h
    end
    serialized
  end

  def self.retrieve_data
    @proposals = []
  end
  
  def self.empty
    @proposals=[]
  end
  
  class Proposal
  	def initialize(title, content)
  	  @title = title
  	  @content = content
  	end
  	def to_h 
  		{"title": @title, "content": @content }
  	end
  end
end
