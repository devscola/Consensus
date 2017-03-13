require 'spec_helper_tdd'
require_relative './../../services/authorization_service'

describe AuthorizationService do
  it 'tells if an username and a password are related' do
    register_some_user

    result = AuthorizationService.verify('some_random_user' , '123test')

    expect(result).to be(true)
  end

  it 'tells if an username and a password dont correspond' do
    register_some_user
    result = AuthorizationService.verify('Jaime', 'other-password')

    expect(result).to be(false)
  end

  it 'accepts nil' do
    result = AuthorizationService.verify(nil, nil)

    expect(result).to be(false)
  end

  it 'accepts nil as password' do
    result = AuthorizationService.verify('Name', nil)

    expect(result).to be(false)
  end

  def register_some_user
    some_username = 'some_random_user'
    some_user_password = '123test'
    Repository.store(some_username, some_user_password)
  end
end
