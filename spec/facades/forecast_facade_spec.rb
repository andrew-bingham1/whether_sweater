require 'rails_helper'

RSpec.describe ForecastFacade do
  it 'returns a forecast object',  vcr: { record: :new_episodes } do
    forecast_facade = ForecastFacade.new('denver,co')
    forecast = forecast_facade.forecast

    expect(forecast).to be_a(Forecast)
    expect(forecast.data).to be_a(Hash)
    expect(forecast.data).to have_key(:location)
    expect(forecast.data[:location]).to be_a(Hash)
    expect(forecast.data).to have_key(:current)
    expect(forecast.data[:current]).to be_a(Hash)
    expect(forecast.data).to have_key(:forecast)
    expect(forecast.data[:forecast]).to be_a(Hash)
  end

  it 'returns a forecast object #2',  vcr: { record: :new_episodes } do
    forecast_facade = ForecastFacade.new('Panama City, Panama')
    forecast = forecast_facade.forecast

    expect(forecast).to be_a(Forecast)
    expect(forecast.data).to be_a(Hash)
    expect(forecast.data).to have_key(:location)
    expect(forecast.data[:location]).to be_a(Hash)
    expect(forecast.data).to have_key(:current)
    expect(forecast.data[:current]).to be_a(Hash)
    expect(forecast.data).to have_key(:forecast)
    expect(forecast.data[:forecast]).to be_a(Hash)
  end
end