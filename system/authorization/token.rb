module Authorization
  class Token
    attr_reader :md5, :username
    def initialize(username, md5)
      @username = username
      @md5 = md5
    end
  end
end
