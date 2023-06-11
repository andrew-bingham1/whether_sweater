require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes', :vcr do
    forecast_service = ForecastService.new
    lat = 39.74001
    lng = -104.99202
    forecast_response = forecast_service.get_forecast(lat, lng)
    forecast = Forecast.new(forecast_response)
    
    expect(forecast).to be_a(Forecast)
    expect(forecast.data).to be_a(Hash)
    expect(forecast.data).to have_key(:location)
    expect(forecast.data[:location]).to be_a(Hash)
    expect(forecast.data[:location]).to have_key(:name)
    expect(forecast.data[:location][:name]).to be_a(String)
    expect(forecast.data[:location][:name]).to eq("Denver")
    
    expect(forecast.data).to have_key(:current)
    expect(forecast.data[:current]).to be_a(Hash)
    expect(forecast.data[:current]).to have_key(:temp_f)
    expect(forecast.data[:current][:temp_f]).to be_a(Float)

    expect(forecast.data).to have_key(:forecast)
    expect(forecast.data[:forecast]).to be_a(Hash)
    expect(forecast.data[:forecast]).to have_key(:forecastday)
    expect(forecast.data[:forecast][:forecastday]).to be_an(Array) 
    expect(forecast.data[:forecast][:forecastday].count).to eq(6)
  end
end