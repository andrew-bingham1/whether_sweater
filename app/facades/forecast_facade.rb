class ForecastFacade
  def initialize(location)
    @location = location
  end

  def forecast
    loc = get_location
    get_forecast(loc)
  end

  private

  def get_location
    response = location_service.get_location(@location)
    Location.new(response)
  end

  def get_forecast(loc)
    forecast_response = forecast_service.get_forecast(loc.lat, loc.lng)
    Forecast.new(forecast_response)
  end

  def location_service
    @_location_service ||= LocationService.new
  end

  def forecast_service
    @_forecast_service ||= ForecastService.new
  end
end