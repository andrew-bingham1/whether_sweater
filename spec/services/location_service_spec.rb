require 'rails_helper'

RSpec.describe LocationService do
  it 'can create get a locations coordinates',  vcr: { record: :new_episodes } do
    location_service = LocationService.new
    location = 'denver,co'
    location_response = location_service.get_location(location)

    expect(location_response).to be_a(Hash)

    expect(location_response).to have_key(:results)
    expect(location_response[:results]).to be_an(Array)

    expect(location_response[:results][0]).to have_key(:locations)
    expect(location_response[:results][0][:locations]).to be_an(Array)

    expect(location_response[:results][0][:locations][0]).to have_key(:latLng)
    expect(location_response[:results][0][:locations][0][:latLng]).to be_a(Hash)

    expect(location_response[:results][0][:locations][0][:latLng]).to have_key(:lat)
    expect(location_response[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
    expect(location_response[:results][0][:locations][0][:latLng][:lat]).to eq(39.74001)

    expect(location_response[:results][0][:locations][0][:latLng]).to have_key(:lng)
    expect(location_response[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    expect(location_response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.99202)
  end

  it 'can get directions',  vcr: { record: :new_episodes } do
    location_service = LocationService.new
    start = 'denver,co'
    destination = 'pueblo,co'

    directions_response = location_service.get_directions(start, destination)

    expect(directions_response).to be_a(Hash)

    expect(directions_response).to have_key(:route)
    expect(directions_response[:route]).to be_a(Hash)

    expect(directions_response[:route]).to have_key(:formattedTime)
    expect(directions_response[:route][:formattedTime]).to be_a(String)

    expect(directions_response[:route]).to have_key(:realTime) 
    expect(directions_response[:route][:realTime]).to be_a(Integer)
  end
end