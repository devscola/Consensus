require_relative './repository'
require_relative '../proposals/service'

module Authorization
  class Service
    def self.verify(username, password)
      return false if (username.nil? || password.nil?)

      credential = Repository.retrieve(username)
      if( credential.secured_by?(password) )
        Repository.token(username)
      else
        false
      end
    end

    def self.users
      list_users = Repository.retrieve_list_users
      list_users.sort
    end

    def self.decode(md5)
      Repository.retrieve_username(md5)
    end

    def self.decode_token(md5)
      Repository.retrieve_token(md5)
    end

  end
end
