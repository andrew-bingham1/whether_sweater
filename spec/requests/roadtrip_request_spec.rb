require 'rails_helper'

RSpec.describe 'Roadtrip API' do
  describe 'happy paths' do
    it 'can get a roadtrip',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'biscuitsarethebest@email.com', password: 'test', password_confirmation: 'test', api_key: '1234567890')
      body = { 
        origin: 'New York, NY',
        destination: 'Los Angeles, CA',
        api_key: user.api_key
      }.to_json

      post '/api/v0/road_trip', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to be_a(Hash)

      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to eq(nil)
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('road_trip')

      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to be_a(Hash)

      expect(json_response[:data][:attributes]).to have_key(:start_city)
      expect(json_response[:data][:attributes][:start_city]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:end_city)
      expect(json_response[:data][:attributes][:end_city]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:travel_time)
      expect(json_response[:data][:attributes][:travel_time]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json_response[:data][:attributes][:weather_at_eta]).to be_a(Hash)

      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(json_response[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      
      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(json_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)

      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(json_response[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)

      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:sunrise)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:sunset)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:feels_like)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:humidity)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:uvi)
    end

    it 'can get a roadtrip with a different destination',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'biscuitsarethebest@email.com', password: 'test', password_confirmation: 'test', api_key: '1234567890')
      body = { 
        origin: 'New York, NY',
        destination: 'Panama City, Panama',
        api_key: user.api_key
      }.to_json

      post '/api/v0/road_trip', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to be_a(Hash)

      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to eq(nil)
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('road_trip')

      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to be_a(Hash)

      expect(json_response[:data][:attributes]).to have_key(:start_city)
      expect(json_response[:data][:attributes][:start_city]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:end_city)
      expect(json_response[:data][:attributes][:end_city]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:travel_time)
      expect(json_response[:data][:attributes][:travel_time]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json_response[:data][:attributes][:weather_at_eta]).to be_a(Hash)

      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(json_response[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      
      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(json_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)

      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(json_response[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)

      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:sunrise)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:sunset)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:feels_like)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:humidity)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:pressure)
    end

    it 'can get a roadtrip with an impossible destination',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'biscuitsarethebest@email.com', password: 'test', password_confirmation: 'test', api_key: '1234567890')
      body = { 
        origin: 'New York, NY',
        destination: 'London, UK',
        api_key: user.api_key
      }.to_json

      post '/api/v0/road_trip', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to be_a(Hash)

      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to eq(nil)

      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('road_trip')

      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to be_a(Hash)

      expect(json_response[:data][:attributes]).to have_key(:start_city)
      expect(json_response[:data][:attributes][:start_city]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:end_city)
      expect(json_response[:data][:attributes][:end_city]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:travel_time)
      expect(json_response[:data][:attributes][:travel_time]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json_response[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(json_response[:data][:attributes][:weather_at_eta]).to be_empty

      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:datetime)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:temperature)
      expect(json_response[:data][:attributes][:weather_at_eta]).to_not have_key(:conditions)
    end
  end

  describe 'sad paths' do
    it 'returns an error if the api key is not valid',  vcr: { record: :new_episodes } do
      body = { 
        origin: 'New York, NY',
        destination: 'Los Angeles, CA',
        api_key: 'biscuits'
      }.to_json

      post '/api/v0/road_trip', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)

      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Bad Credentials')
    end

    it 'can handle locations on another planet',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'biscuitsarethebest@email.com', password: 'test', password_confirmation: 'test', api_key: '1234567890')
      body = { 
        origin: 'New York, NY',
        destination: 'Mars, Space',
        api_key: user.api_key
      }.to_json

      post '/api/v0/road_trip', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:id]).to eq(nil)
      expect(json_response[:data][:type]).to eq('road_trip')
      expect(json_response[:data]).to have_key(:attributes)

      expect(json_response[:data][:attributes]).to have_key(:start_city)
      expect(json_response[:data][:attributes][:start_city]).to eq('New York, NY')

      expect(json_response[:data][:attributes]).to have_key(:end_city)
      expect(json_response[:data][:attributes][:end_city]).to eq('Mars, Space')

      expect(json_response[:data][:attributes]).to have_key(:travel_time)
      expect(json_response[:data][:attributes][:travel_time]).to eq('impossible')

      expect(json_response[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json_response[:data][:attributes][:weather_at_eta]).to be_empty

      expect(json_response[:data][:attributes]).to_not have_key(:start_latitude)
      expect(json_response[:data][:attributes]).to_not have_key(:start_longitude)
      expect(json_response[:data][:attributes]).to_not have_key(:end_latitude)
      expect(json_response[:data][:attributes]).to_not have_key(:end_longitude)
    end
  end
end