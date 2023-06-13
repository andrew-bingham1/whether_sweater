require 'rails_helper'

RSpec.describe ForecastSerializer do
  it 'serializes a forecast object',  vcr: { record: :new_episodes } do
    forecast_service = ForecastService.new
    lat = 39.74001
    lng = -104.99202
    forecast_response = forecast_service.get_forecast(lat, lng)
    forecast = Forecast.new(forecast_response)
    serialized_forecast = ForecastSerializer.new(forecast)
    json = JSON.parse(serialized_forecast.to_json, symbolize_names: true)
    
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)

    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)

    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('forecast')

    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:current_weather)
    expect(json[:data][:attributes][:current_weather]).to be_a(Hash)
    expect(json[:data][:attributes][:current_weather]).to have_key(:last_updated)
    expect(json[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
    expect(json[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(json[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
    expect(json[:data][:attributes][:current_weather]).to have_key(:feels_like)
    expect(json[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
    expect(json[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(json[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
    expect(json[:data][:attributes][:current_weather]).to have_key(:uvi)
    expect(json[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
    expect(json[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(json[:data][:attributes][:current_weather][:visibility]).to be_a(Float)
    expect(json[:data][:attributes][:current_weather]).to have_key(:condition)
    expect(json[:data][:attributes][:current_weather][:condition]).to be_a(String)
    expect(json[:data][:attributes][:current_weather]).to have_key(:icon)
    expect(json[:data][:attributes][:current_weather][:icon]).to be_a(String)

    expect(json[:data][:attributes]).to have_key(:daily_weather)
    expect(json[:data][:attributes][:daily_weather]).to be_an(Array)
    expect(json[:data][:attributes][:daily_weather].count).to eq(6)
    expect(json[:data][:attributes][:daily_weather].first).to be_a(Hash)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:date)
    expect(json[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:sunrise)
    expect(json[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:sunset)
    expect(json[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:max_temp)
    expect(json[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Float)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:min_temp)
    expect(json[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Float)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:condition)
    expect(json[:data][:attributes][:daily_weather].first[:condition]).to be_a(String)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:icon)
    expect(json[:data][:attributes][:daily_weather].first[:icon]).to be_a(String)

    expect(json[:data][:attributes]).to have_key(:hourly_weather)
    expect(json[:data][:attributes][:hourly_weather]).to be_an(Array)
    expect(json[:data][:attributes][:hourly_weather].count).to eq(24)
    expect(json[:data][:attributes][:hourly_weather].first).to be_a(Hash)
    expect(json[:data][:attributes][:hourly_weather].first).to have_key(:time)
    expect(json[:data][:attributes][:hourly_weather].first[:time]).to be_a(String)
    expect(json[:data][:attributes][:hourly_weather].first[:time]).to eq("00:00")
    expect(json[:data][:attributes][:hourly_weather].first).to have_key(:temperature)
    expect(json[:data][:attributes][:hourly_weather].first[:temperature]).to be_a(Float)
    expect(json[:data][:attributes][:hourly_weather].first).to have_key(:condition)
    expect(json[:data][:attributes][:hourly_weather].first[:condition]).to be_a(String)
    expect(json[:data][:attributes][:hourly_weather].first).to have_key(:icon)
    expect(json[:data][:attributes][:hourly_weather].first[:icon]).to be_a(String)
  end
end


