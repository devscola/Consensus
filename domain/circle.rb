module Domain
  class Circle
    def initialize
      @involved = []
    end

    def involve(person)
      return if involved?(person)
      @involved.push(person)
    end

    def involved
      @involved
    end

    def involved? person
      @involved.include?(person)
    end
  end
end
