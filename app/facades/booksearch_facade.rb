class BooksearchFacade
  def initialize(location, quantity)
    @location = location
    @quantity = quantity
  end

  def booksearch
    Booksearch.new(get_book_data, get_forecast_data)
  end
private

  def get_book_data
    BooksearchService.new.get_books(@location, @quantity)
  end

  def get_forecast_data
    ForecastFacade.new(@location).forecast
  end
end