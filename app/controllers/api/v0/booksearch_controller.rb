class Api::V0::BooksearchController < ApplicationController
  def index
    forecast = ForecastFacade.new(params[:location]).forecast
    booksearch = BooksearchService.new.get_books(params[:location])
    require 'pry'; binding.pry
  end


end
