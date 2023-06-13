require 'rails_helper'

RSpec.describe Roadtrip do
  it 'exists and has attributes',  vcr: { record: :new_episodes } do
    road_trip = RoadTripFacade.new('New York, NY', 'Los Angeles, CA').road_trip

    expect(road_trip).to be_a(Roadtrip)
    expect(road_trip.data).to be_a(Hash)
    expect(road_trip.data[:start_city]).to be_a(String)
    expect(road_trip.data[:end_city]).to be_a(String)
    expect(road_trip.data[:travel_time]).to be_a(String)
    expect(road_trip.data[:weather_at_eta]).to be_a(Hash)
    expect(road_trip.data[:weather_at_eta][:datetime]).to be_a(String)
    expect(road_trip.data[:weather_at_eta][:temperature]).to be_a(Float)
    expect(road_trip.data[:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'exists and has attributes #2',  vcr: { record: :new_episodes } do
    road_trip = RoadTripFacade.new('New York, NY', 'Panama City, Panama').road_trip

    expect(road_trip).to be_a(Roadtrip)
    expect(road_trip.data).to be_a(Hash)
    expect(road_trip.data[:start_city]).to be_a(String)
    expect(road_trip.data[:end_city]).to be_a(String)
    expect(road_trip.data[:travel_time]).to be_a(String)
    expect(road_trip.data[:weather_at_eta]).to be_a(Hash)
    expect(road_trip.data[:weather_at_eta][:datetime]).to be_a(String)
    expect(road_trip.data[:weather_at_eta][:temperature]).to be_a(Float)
    expect(road_trip.data[:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'exists and has attributes with impossible route',  vcr: { record: :new_episodes } do
    road_trip = RoadTripFacade.new('New York, NY', 'London, UK').road_trip

    expect(road_trip).to be_a(Roadtrip)
    expect(road_trip.data).to be_a(Hash)
    expect(road_trip.data[:start_city]).to be_a(String)
    expect(road_trip.data[:end_city]).to be_a(String)
    expect(road_trip.data[:travel_time]).to eq('impossible')
    expect(road_trip.data[:weather_at_eta]).to eq({})
  end
end