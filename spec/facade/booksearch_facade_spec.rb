require 'rails_helper'

RSpec.describe BooksearchFacade do 
  it 'returns a booksearch object', :vcr do
    location = 'denver,co'
    quantity = 5
    booksearch = BooksearchFacade.new(location, quantity).booksearch
    
    expect(booksearch).to be_a(Booksearch)
    expect(booksearch.book_data).to be_a(Hash)
    expect(booksearch.forecast_data).to be_a(Forecast)
  end
end