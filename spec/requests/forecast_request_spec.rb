require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'sends a forecast for a city',  vcr: { record: :new_episodes } do
    get '/api/v0/forecast?location=denver,co'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)

    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)

    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('forecast')

    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:current_weather)
    expect(json[:data][:attributes][:current_weather]).to have_key(:last_updated)
    expect(json[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(json[:data][:attributes][:current_weather]).to have_key(:feels_like)
    expect(json[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(json[:data][:attributes][:current_weather]).to have_key(:uvi)
    expect(json[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(json[:data][:attributes][:current_weather]).to have_key(:condition)
    expect(json[:data][:attributes][:current_weather]).to have_key(:icon)
    

    expect(json[:data][:attributes]).to have_key(:daily_weather)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:date)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:sunrise)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:sunset)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:max_temp)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:min_temp)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:condition)
    expect(json[:data][:attributes][:daily_weather].first).to have_key(:icon)


    expect(json[:data][:attributes]).to have_key(:hourly_weather)
    expect(json[:data][:attributes][:hourly_weather]).to be_an(Array)
    expect(json[:data][:attributes][:hourly_weather].count).to eq(24)
    expect(json[:data][:attributes][:hourly_weather].first).to be_a(Hash)
    expect(json[:data][:attributes][:hourly_weather].first).to have_key(:time)
    expect(json[:data][:attributes][:hourly_weather].first).to have_key(:temperature)
    expect(json[:data][:attributes][:hourly_weather].first).to have_key(:condition)
    expect(json[:data][:attributes][:hourly_weather].first).to have_key(:icon)

    expect(json[:data][:attributes]).to_not have_key(:astro)
    expect(json[:data][:attributes]).to_not have_key(:day)
    expect(json[:data][:attributes]).to_not have_key(:current)
    expect(json[:data][:attributes]).to_not have_key(:forecast)
    expect(json[:data][:attributes]).to_not have_key(:forecastday)
    expect(json[:data][:attributes]).to_not have_key(:hourly)
  end
end