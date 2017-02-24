require_relative 'repository'

class AuthorizationService
  def self.verify(username, password)
    return false if (username.nil? || password.nil?)
    registered_password = Repository.retrieve(username)

    return (registered_password == password)
  end
end
