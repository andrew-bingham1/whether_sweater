require 'rails_helper'

RSpec.describe ForecastService do
  it 'can get a forecast', :vcr do
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
end