class Api::V0::BooksearchController < ApplicationController
  def index
    forecast = ForecastFacade.new(params[:location]).forecast
    booksearch = BooksearchService.new(params[:location]).get_books
  end

  private 

  def booksearch_params
    params.permit(:location, :quantity)
  end
end
