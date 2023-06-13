require 'rails_helper'

RSpec.describe RoadTripFacade do
  it 'can create a road trip object', vcr: { record: :new_episodes } do
    road_trip_facade = RoadTripFacade.new('New York, NY', 'Los Angeles, CA')
    trip = road_trip_facade.road_trip

    expect(trip).to be_a(Roadtrip)
    expect(trip.data).to be_a(Hash)
    expect(trip.data[:start_city]).to be_a(String)
    expect(trip.data[:end_city]).to be_a(String)
    expect(trip.data[:travel_time]).to be_a(String)
    expect(trip.data[:weather_at_eta]).to be_a(Hash)
    expect(trip.data[:weather_at_eta][:datetime]).to be_a(String)
    expect(trip.data[:weather_at_eta][:temperature]).to be_a(Float)
    expect(trip.data[:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'can create a road trip object #2', vcr: { record: :new_episodes } do
    road_trip_facade = RoadTripFacade.new('New York, NY', 'Panama City, Panama')
    trip = road_trip_facade.road_trip

    expect(trip).to be_a(Roadtrip)
    expect(trip.data).to be_a(Hash)
    expect(trip.data[:start_city]).to be_a(String)
    expect(trip.data[:end_city]).to be_a(String)
    expect(trip.data[:travel_time]).to be_a(String)
    expect(trip.data[:weather_at_eta]).to be_a(Hash)
    expect(trip.data[:weather_at_eta][:datetime]).to be_a(String)
    expect(trip.data[:weather_at_eta][:temperature]).to be_a(Float)
    expect(trip.data[:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'can create a road trip object with impossible route', vcr: { record: :new_episodes } do
    road_trip_facade = RoadTripFacade.new('New York, NY', 'London, UK')
    trip = road_trip_facade.road_trip

    expect(trip).to be_a(Roadtrip)
    expect(trip.data).to be_a(Hash)
    expect(trip.data[:start_city]).to be_a(String)
    expect(trip.data[:end_city]).to be_a(String)
    expect(trip.data[:travel_time]).to eq('impossible')
    expect(trip.data[:weather_at_eta]).to eq({})
  end
end