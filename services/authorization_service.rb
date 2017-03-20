require_relative 'repository'

class AuthorizationService
  def self.verify(username, password)
    return false if (username.nil? || password.nil?)
    credential = Repository.retrieve(username)

    return credential.is_secured_by?(password)
  end
end

