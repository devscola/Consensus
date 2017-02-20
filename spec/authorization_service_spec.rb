require 'spec_helper'
require_relative './../repository'
require_relative './../authorization_service'

describe AuthorizationService do
  it "tells if an username and a password are related" do
    register_some_user
    incidental_credentials = { username: "some_random_user" , password: "123test" }

    result = AuthorizationService.verify(incidental_credentials)

    expect(result).to be(true)
  end

  it 'tells if an username and a password dont correspond' do
    incidental_credentials = { username: "Jaime", password: 'other-password'}
    register_some_user
    result = AuthorizationService.verify(incidental_credentials)

    expect(result).to be(false)
  end

  it 'doesnt accept unformatted data' do
    unformatted_data = 'some_random_data'

    expect{ 
      AuthorizationService.verify(unformatted_data)
      }.to raise_error(
        AuthorizationService::InvalidFormatError
        )
  end

  def register_some_user
    some_username = 'some_random_user'
    some_user_password = '123test'
    Repository.store(some_username, some_user_password)
  end
end
