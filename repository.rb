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

    def store(key, item)
      @contents ||= prepare_fake_users

      @contents[key] = item
    end

    def retrieve(key)
      @contents ||= prepare_fake_users

      @contents[key]
    end

    private

    def prepare_fake_users
      correspondencies = {}

      LOGIN_CREDENTIALS.each do |user_credentials|
        correspondencies[user_credentials[:username]] = user_credentials[:password] 
      end

      correspondencies
    end
  end
end
