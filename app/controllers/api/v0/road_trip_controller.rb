class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user 
      road_trip = RoadTripFacade.new(params[:origin], params[:destination]).road_trip
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { errors: 'Bad Credentials' }, status: :unauthorized
    end
  end
end