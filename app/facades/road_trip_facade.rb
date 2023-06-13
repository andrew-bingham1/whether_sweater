class RoadTripFacade
  def initialize(start, destination)
    @start = start
    @destination = destination
  end

  def road_trip
    route = location_service.get_directions(@start, @destination)
    if route[:info][:statuscode] == 0
      arrival = Time.now.to_i + route[:route][:realTime]
      location_response = location_service.get_location(@destination)
      location = Location.new(location_response)
      arrival_timezone = timezone_service.get_timezone(location.lat, location.lng)
      time_at_destination = Time.at(arrival).in_time_zone(arrival_timezone[:zoneName])
      arrival_date = time_at_destination.strftime("%Y-%m-%d")
      arrival_time = time_at_destination.strftime("%H")
      arrival_date_time = time_at_destination.strftime("%Y-%m-%d %H:%M")
      forecast = forecast_service.get_future_forecast(@destination, arrival_date, arrival_time)
      weather_eta = weather_at_eta(forecast, arrival_date_time)

      data = {
        start_city: @start,
        end_city: @destination,
        travel_time: route[:route][:formattedTime],
        weather_at_eta: weather_eta
      }

    else
      data = {
        start_city: @start,
        end_city: @destination,
        travel_time: "impossible",
        weather_at_eta: {}
      }
    end

    Roadtrip.new(data)
  end

  private
  
  def weather_at_eta(forecast, arrival_date_time)
    {
      datetime: arrival_date_time,
      temperature: forecast[:forecast][:forecastday][0][:hour][0][:temp_f],
      conditions: forecast[:forecast][:forecastday][0][:hour][0][:condition][:text]
    }
  end

  def location_service
    @_location_service ||= LocationService.new
  end

  def forecast_service
    @_forecast_service ||= ForecastService.new
  end

  def timezone_service
    @_timezone_service ||= TimezoneService.new
  end

end
