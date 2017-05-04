module Domain
  class Credential
    def initialize(login, passphrase = nil)
      @username = login
      @password = passphrase
    end
  end
end