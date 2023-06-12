class Api::V1::BooksearchController < ApplicationController
  def index
    if params[:location].nil? || params[:location].empty?
      render json: {errors: 'Must Provide a Location'}, status: 400
    elsif params[:quantity].to_i < 1 
      render json: {errors: 'Must Provide a Quantity Greater Than 0'}, status: 400
    else
      booksearch = BooksearchFacade.new(params[:location],params[:quantity]).booksearch
      render json: BooksSerializer.new(booksearch), status: 200
    end
  end
end