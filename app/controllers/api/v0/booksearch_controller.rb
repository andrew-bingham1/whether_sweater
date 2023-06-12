class Api::V0::BooksearchController < ApplicationController
  def index
    book_data = BooksearchService.new.get_books(params[:location], params[:quantity])
    forecast_data = ForecastFacade.new(params[:location]).forecast
    
    booksearch = Booksearch.new(book_data, forecast_data)
    require 'pry'; binding.pry
  end


end
