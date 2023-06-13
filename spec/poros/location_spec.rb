require 'rails_helper'

RSpec.describe Location do
  it 'exists and has attributes',  vcr: { record: :new_episodes } do
    location_service = LocationService.new
    location = 'denver,co'
    location_response = location_service.get_location(location)

    location = Location.new(location_response)

    expect(location).to be_a(Location)
    expect(location.lat).to be_a(Float)
    expect(location.lat).to eq(39.74001)
    expect(location.lng).to be_a(Float)
    expect(location.lng).to eq(-104.99202)
  end
end