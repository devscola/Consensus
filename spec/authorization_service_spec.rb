require 'spec_helper'
require_relative './../authorization_service'

describe AuthorizationService do
  it "tells if an username and a password are related" do
    actual_credentials = { username: "Jaime", password: "123" }
    incidental_credentials = { username: "Jaime" , password: "123" }

    result = AuthorizationService.verify(incidental_credentials)

    expect(result).to be(true)
  end
end
