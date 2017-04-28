module Proposals
  class Circle < Domain::Circle
    def self.from_bson(a_circle)
      the_circle = Proposals::Circle.new
      a_circle.each{|person| the_circle.involve(person)}
      the_circle
    end

    def involved
      @involved.dup
    end
  end
end
