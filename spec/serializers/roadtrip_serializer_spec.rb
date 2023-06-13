require 'rails_helper'

RSpec.describe RoadTripSerializer do
  it 'can serialize a roadtrip object', vcr: { record: :new_episodes } do
    origin = 'New York, NY'
    destination = 'Los Angeles, CA'
  
    road_trip = RoadTripFacade.new(origin, destination).road_trip
    serialized_road_trip = RoadTripSerializer.new(road_trip)

    expect(serialized_road_trip).to be_a(RoadTripSerializer)
    json = JSON.parse(serialized_road_trip.to_json, symbolize_names: true)
    
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)

    expect(json[:data]).to be_a(Hash)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data][:type]).to eq('road_trip')

    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes][:start_city]).to eq(origin)
    expect(json[:data][:attributes][:end_city]).to eq(destination)
    expect(json[:data][:attributes][:travel_time]).to be_a(String)

    expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(json[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
    expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)

    expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:sunrise)
    expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:sunset)
    expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:feels_like)
    expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:humidity)
    expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:uvi)
  end

  it 'can serialize a roadtrip object #2', vcr: { record: :new_episodes } do
    origin = 'New York, NY'
    destination = 'London, UK'

    road_trip = RoadTripFacade.new(origin, destination).road_trip
    serialized_road_trip = RoadTripSerializer.new(road_trip)
    json = JSON.parse(serialized_road_trip.to_json, symbolize_names: true)

    expect(serialized_road_trip).to be_a(RoadTripSerializer)
    
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)

    expect(json[:data]).to be_a(Hash)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data][:type]).to eq('road_trip')

    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes][:start_city]).to eq(origin)
    expect(json[:data][:attributes][:end_city]).to eq(destination)
    expect(json[:data][:attributes][:travel_time]).to be_a(String)

    expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:datetime)
    expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:temperature)
    expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:conditions)
  end
end