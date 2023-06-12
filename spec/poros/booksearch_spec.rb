require 'rails_helper'

RSpec.describe Booksearch do
  it 'exists and has attributes', :vcr do
    location = 'denver,co'
    limit = 5
    book_data = BooksearchService.new.get_books(location, limit)
    forecast_data = ForecastFacade.new(location).forecast

    booksearch = Booksearch.new(book_data, forecast_data)
  end
end