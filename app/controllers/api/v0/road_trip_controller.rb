class Api::V0::RoadTripController < ApplicationController
  wrap_parameters :road_trip, include: [:origin, :destination, :api_key]
  def create
    user = User.find_by(api_key: params[:api_key])
    if user 
      road_trip = RoadTripFacade.new(params[:origin], params[:destination]).road_trip
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { errors: 'Bad Credentials' }, status: :unauthorized
    end
  end

  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination, :api_key)
  end
end