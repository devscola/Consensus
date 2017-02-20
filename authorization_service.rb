require_relative 'repository'

class AuthorizationService
  def self.verify(credentials)
    begin  
      username = credentials[:username]
      password = credentials[:password]
    rescue TypeError
      raise InvalidFormatError
    end

    registered_password = Repository.retrieve(username)

    registered_password == password
  end

  class InvalidFormatError < ArgumentError
  end
end
