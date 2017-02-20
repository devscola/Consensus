class Repository
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
  ]

  def initialize
    @contents = {}
  end

  def store(key, item)
    @contents[key] = item
  end

  def retrieve(key)
    @contents[key]
  end
end
