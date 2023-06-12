require 'rails_helper'

RSpec.describe Booksearch do
  it 'exists and has attributes', :vcr do
    location = 'denver,co'
    limit = 5
    book_data = BooksearchService.new.get_books(location, limit)
    forecast_data = ForecastFacade.new(location).forecast

    booksearch = Booksearch.new(book_data, forecast_data)

    expect(booksearch).to be_a(Booksearch)
    expect(booksearch.book_data).to be_a(Hash)
    expect(booksearch.book_data[:docs]).to be_an(Array)
    expect(booksearch.book_data[:docs].count).to eq(5)
    expect(booksearch.forecast_data).to be_a(Forecast)
    expect(booksearch.forecast_data.data).to be_a(Hash)
    expect(booksearch.forecast_data.data[:location]).to be_a(Hash)
    expect(booksearch.forecast_data.data[:current]).to be_a(Hash)
  end

  it 'exists and has attributes #2', :vcr do
    location = 'colorado springs,co'
    limit = 5
    book_data = BooksearchService.new.get_books(location, limit)
    forecast_data = ForecastFacade.new(location).forecast

    booksearch = Booksearch.new(book_data, forecast_data)

    expect(booksearch).to be_a(Booksearch)
    expect(booksearch.book_data).to be_a(Hash)
    expect(booksearch.book_data[:docs]).to be_an(Array)
    expect(booksearch.book_data[:docs].count).to eq(5)
    expect(booksearch.forecast_data).to be_a(Forecast)
    expect(booksearch.forecast_data.data).to be_a(Hash)
    expect(booksearch.forecast_data.data[:location]).to be_a(Hash)
    expect(booksearch.forecast_data.data[:current]).to be_a(Hash)
  end
end