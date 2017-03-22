require_relative './repository'

module Authorization 
	class Service
	  def self.verify(username, password)
	    return false if (username.nil? || password.nil?)
	    credential = Repository.retrieve(username)

	    return credential.is_secured_by?(password)
	  end

    def self.users
      list_users = Repository.retrieve_list_users
      list_users.sort
    end
	end
end
