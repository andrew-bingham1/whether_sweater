class Booksearch
  attr_reader :id, :book_data, :forecast_data
  def initialize(book_data, forecast_data)
    @book_data = book_data
    @forecast_data = forecast_data
  end
end