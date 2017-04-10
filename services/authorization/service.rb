require_relative './repository'

module Authorization
	class Service
		@tokens = []

	  def self.verify(username, password)
	    return false if (username.nil? || password.nil?)

	    credential = Repository.retrieve(username)
			if( credential.is_secured_by?(password) )
				token = Repository.generate_token(username)

				@tokens << token

				token
			else
				false
			end
	  end

		def self.tokens
			@tokens
		end

    def self.users
      list_users = Repository.retrieve_list_users
      list_users.sort
    end
	end
end
