require 'faraday'

class LocationService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_location(location)
    get_url("/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{location}")
  end
end