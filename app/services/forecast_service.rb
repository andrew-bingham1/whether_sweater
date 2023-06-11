require 'faraday'

class ForecastService
  
  def get_forecast(lat, lng)
    get_url("v1/forecast.json?key=#{ENV['WEATHER_API_KEY']}&q=#{lat},#{lng}&days=6&aqi=no&alerts=no")
  end
  
  private

  def conn
    Faraday.new(url: "http://api.weatherapi.com/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
end