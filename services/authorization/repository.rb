module Authorization
  class Repository
    class << self
      LOGIN_CREDENTIALS = [
        {
          :username => 'KingRobert',
          :password => 'Stag'
        },
        {
          :username => 'Cersei',
          :password => 'Lion'
        },
        {
          :username => 'Khaleesi',
          :password => 'Dragon'
        },
        {
          :username => 'Arya',
          :password => 'Wolf'
        },
        {
          :username => 'Varys',
          :password => 'Bird'
        },
        {
          :username => 'Joffrey',
          :password => 'Asshole'
        },
        {
          :username => 'LyanaMormont',
          :password => 'Badass'
        }
      ].freeze
      private_constant :LOGIN_CREDENTIALS

      def store(username, password)
        @contents ||= retrieve_data

        @contents << Credential.new(username, password)
      end

      def retrieve(username)
        @contents ||= retrieve_data

        result = @contents.find do |credential|
          credential.responds_to?(username)
        end

        result = Credential.get_null if result.nil?
        result
      end

      private

      def retrieve_data
        credentials = []

        LOGIN_CREDENTIALS.each do |user_credentials|
          username = user_credentials[:username]
          password = user_credentials[:password]

          credentials << Credential.new(username, password)
        end

        credentials
      end
    end

    class Credential
      def self.get_null
        NullCredential.new(nil, nil)
      end

      def initialize(login, passphrase)
        @username = login
        @password = passphrase
      end

      def responds_to?(login)
        return (@username == login)
      end

      def is_secured_by?(passphrase)
        return (@password == passphrase)
      end

      class NullCredential < Credential
        def is_secured_by?(passphrase)
          return false
        end
      end
    end
  end
end
