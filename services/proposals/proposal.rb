class Proposal
  def self.from_bson bson
    the_proposal=Proposal.new(bson['id'],bson['proposer'])
    the_proposal.attach(bson['title'],bson['content'])
    the_proposal.create_circle(bson['circle'])
    the_proposal
  end

  def initialize(id,proposer)
    @id = id
    @circle=[]
    @proposer=proposer
    involve(@proposer)
  end

  def attach(title,content)
    @title = title
    @content = content
  end

  def involve(person)
    return if involved?(person)
    @circle.push(person)
  end

  def involved
    @circle
  end

  def involved? person
    @circle.include?(person)
  end

  def create_circle(a_circle)
    a_circle.each{|person| involve(person)}
  end

  def to_h
    { 'title': @title, 'content': @content, 'proposer': @proposer, 'id': @id, 'circle': @circle }
  end
end
