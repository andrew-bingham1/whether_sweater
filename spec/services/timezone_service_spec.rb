require 'rails_helper'

RSpec.describe TimezoneService do
  it 'can get timezone', vcr: { record: :new_episodes } do
    timezone_service = TimezoneService.new
    lat = 39.74001
    lng = -104.99202
    timezone_response = timezone_service.get_timezone(lat, lng)

    expect(timezone_response).to be_a(Hash)
    expect(timezone_response).to have_key(:zoneName)
    expect(timezone_response[:zoneName]).to be_a(String)
    expect(timezone_response[:zoneName]).to eq("America/Denver")
  end

  it 'can get timezone #2', vcr: { record: :new_episodes } do
    timezone_service = TimezoneService.new
    lat = 8.9824
    lng = -79.5199
    timezone_response = timezone_service.get_timezone(lat, lng)

    expect(timezone_response).to be_a(Hash)
    expect(timezone_response).to have_key(:zoneName)
    expect(timezone_response[:zoneName]).to be_a(String)
    expect(timezone_response[:zoneName]).to eq("America/Panama")
  end
end