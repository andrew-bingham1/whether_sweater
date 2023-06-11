class ForecastSerializer
  include JSONAPI::Serializer

  attributes :current_weather do |forecast|
    {
      last_updated: forecast.data[:current][:last_updated],
      temperature: forecast.data[:current][:temp_f],
      feels_like: forecast.data[:current][:feelslike_f],
      humidity: forecast.data[:current][:humidity],
      uvi: forecast.data[:current][:uv],
      visibility: forecast.data[:current][:vis_miles],
      condition: forecast.data[:current][:condition][:text],
      icon: "https:" + forecast.data[:current][:condition][:icon]
    }
  end

  attributes :daily_weather do |forecast|
    forecast.data[:forecast][:forecastday].map do |daily_data|
      {
        date: daily_data[:date],
        sunrise: daily_data[:astro][:sunrise],
        sunset: daily_data[:astro][:sunset],
        max_temp: daily_data[:day][:maxtemp_f],
        min_temp: daily_data[:day][:mintemp_f],
        condition: daily_data[:day][:condition][:text],
        icon: "https:" + daily_data[:day][:condition][:icon]
      }
    end
  end

  attributes :hourly_weather do |forecast|
    forecast.data[:forecast][:forecastday][0][:hour].map do |hourly_data|
      {
        time: hourly_data[:time].split(' ')[1][0..4],
        temperature: hourly_data[:temp_f],
        condition: hourly_data[:condition][:text],
        icon: "https:" + hourly_data[:condition][:icon]
      }
    end
  end
end

