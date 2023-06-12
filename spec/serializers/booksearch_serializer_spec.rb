require 'rails_helper'

RSpec.describe BooksSerializer do
  it 'serializes a booksearch object', :vcr do
    location = 'denver,co'
    limit = 5
    book_data = BooksearchService.new.get_books(location, limit)
    forecast_data = ForecastFacade.new(location).forecast
    
    booksearch = Booksearch.new(book_data, forecast_data)

    serialized_booksearch = BooksSerializer.new(booksearch)
    json = JSON.parse(serialized_booksearch.to_json, symbolize_names: true)

    expect(json).to be_a(Hash)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data][:type]).to eq('books')
    
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes][:destination]).to be_a(String)
    expect(json[:data][:attributes][:destination]).to eq('denver,co')

    expect(json[:data][:attributes][:forecast]).to be_a(Hash)
    expect(json[:data][:attributes][:forecast][:summary]).to be_a(String)

    


  end
end