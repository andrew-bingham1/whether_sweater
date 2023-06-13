require 'faraday'

class TimezoneService

  def get_timezone(lat, lng)
    get_url("/v2.1/get-time-zone?key=#{ENV['TIMEZONE_API_KEY']}&format=json&by=position&lat=#{lat}&lng=#{lng}")
  end
  
  private
  
  def conn
    Faraday.new(url: "https://api.timezonedb.com")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end


