class Api::V0::BooksearchController < ApplicationController
  def index
    if params[:location].nil? || params[:location].empty?
      render json: {errors: "Must Provide a Location"}, status: 400
    else
      book_data = BooksearchService.new.get_books(params[:location], params[:quantity])
      forecast_data = ForecastFacade.new(params[:location]).forecast
      
      booksearch = Booksearch.new(book_data, forecast_data)
      render json: BooksSerializer.new(booksearch), status: 200
    end
  end
end
