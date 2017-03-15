require 'digest/md5'
class ProposalsService
  def self.add(title, content)
    generated_id = self.generate_id(title.to_s, content.to_s)
		@proposals ||= retrieve_data
    @proposals << Proposal.new(title, content, generated_id)
    generated_id
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

  def self.retrieve(id)
    result = {}
    @proposals.each do |item|
      if(item.to_h[:id] == id)
        result = item
      end
    end
    result
  end

  class Proposal
  	def initialize(title, content, id)
  	  @title = title
  	  @content = content
      @id = id
  	end
  	def to_h 
  		{"title": @title, "content": @content, "id": @id }
  	end
  end

  private
  def self.generate_id(*identifiers)
    Digest::MD5.hexdigest( identifiers.join.to_s )
  end
end
