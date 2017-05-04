module Authorization
  class Credential
    def self.nullified
      NullCredential.new(nil, nil)
    end

    def initialize(login, passphrase = nil)
      @username = login
      @password = passphrase
    end

    def responds_to?(login)
      return (@username == login)
    end

    def secured_by?(passphrase)
      return (@password == passphrase)
    end

    class NullCredential < Credential
      def secured_by?(passphrase)
        return false
      end
    end
  end
end
