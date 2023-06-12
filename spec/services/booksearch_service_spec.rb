require 'rails_helper'

RSpec.describe BooksearchService do
  it 'can get books', :vcr do
    location = 'denver,co'
    limit = 5

    booksearch = BooksearchService.new.get_books(location, limit)

    expect(booksearch).to be_a(Hash)
    expect(booksearch[:docs]).to be_an(Array)
    expect(booksearch[:docs].count).to eq(5)
    expect(booksearch[:numFound]).to eq(758)
  end
end