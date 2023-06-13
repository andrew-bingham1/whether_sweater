require 'rails_helper'

RSpec.describe ForecastService do
  it 'can get a forecast',  vcr: { record: :new_episodes } do
    forecast_service = ForecastService.new
    lat = 39.74001
    lng = -104.99202
    forecast_response = forecast_service.get_forecast(lat, lng)

    expect(forecast_response).to be_a(Hash)

    expect(forecast_response).to have_key(:location)
    expect(forecast_response[:location]).to be_a(Hash)
    expect(forecast_response[:location]).to have_key(:name)
    expect(forecast_response[:location][:name]).to be_a(String)
    expect(forecast_response[:location][:name]).to eq("Denver")

    expect(forecast_response).to have_key(:current)
    expect(forecast_response[:current]).to be_a(Hash)
    expect(forecast_response[:current]).to have_key(:temp_f)
    expect(forecast_response[:current][:temp_f]).to be_a(Float)

    expect(forecast_response).to have_key(:forecast)
    expect(forecast_response[:forecast]).to be_a(Hash)

    expect(forecast_response[:forecast]).to have_key(:forecastday)
    expect(forecast_response[:forecast][:forecastday]).to be_an(Array) 
    expect(forecast_response[:forecast][:forecastday].count).to eq(6)
  end

  it 'can get a forecast for a location at a specific time',  vcr: { record: :new_episodes } do
    forecast_service = ForecastService.new
    city = 'denver'
    date = '2023-06-25'
    hour = '16'

    forecast_response = forecast_service.get_future_forecast(city, date, hour)
    
    expect(forecast_response).to be_a(Hash)

    expect(forecast_response).to have_key(:forecast)
    expect(forecast_response[:forecast]).to be_a(Hash)

    expect(forecast_response[:forecast]).to have_key(:forecastday)
    expect(forecast_response[:forecast][:forecastday]).to be_an(Array)

    expect(forecast_response[:forecast][:forecastday][0]).to be_a(Hash)
    expect(forecast_response[:forecast][:forecastday][0]).to have_key(:hour)
    expect(forecast_response[:forecast][:forecastday][0][:hour]).to be_an(Array)
    expect(forecast_response[:forecast][:forecastday][0][:hour][0]).to be_a(Hash)

    expect(forecast_response[:forecast][:forecastday][0][:hour][0]).to have_key(:time)
    expect(forecast_response[:forecast][:forecastday][0][:hour][0][:time]).to be_a(String)

    expect(forecast_response[:forecast][:forecastday][0][:hour][0]).to have_key(:temp_f)
    expect(forecast_response[:forecast][:forecastday][0][:hour][0][:temp_f]).to be_a(Float)

    expect(forecast_response[:forecast][:forecastday][0][:hour][0][:condition]).to be_a(Hash)
    expect(forecast_response[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:text)
    expect(forecast_response[:forecast][:forecastday][0][:hour][0][:condition][:text]).to be_a(String)
  end
end