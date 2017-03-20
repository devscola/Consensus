require 'spec_helper_tdd'
require_relative './../../services/authorization/service'

describe Authorization::Service do
  it 'tells if an username and a password are related' do
    register_some_user

    result = Authorization::Service.verify('some_random_user' , '123test')

    expect(result).to be(true)
  end

  it 'tells if an username and a password dont correspond' do
    register_some_user
    result = Authorization::Service.verify('Jaime', 'other-password')

    expect(result).to be(false)
  end

  it 'accepts nil' do
    result = Authorization::Service.verify(nil, nil)

    expect(result).to be(false)
  end

  it 'accepts nil as password' do
    result = Authorization::Service.verify('Name', nil)

    expect(result).to be(false)
  end

  def register_some_user
    some_username = 'some_random_user'
    some_user_password = '123test'
    Authorization::Repository.store(some_username, some_user_password)
  end
end
