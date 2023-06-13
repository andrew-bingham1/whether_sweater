class RoadTripSerializer
  include JSONAPI::Serializer 

  set_type :road_trip

  attributes :start_city do |road_trip|
    road_trip.data[:start_city]
  end

  attributes :end_city do |road_trip|
    road_trip.data[:end_city]
  end

  attributes :travel_time do |road_trip| 
    road_trip.data[:travel_time]
  end

  attributes :weather_at_eta do |road_trip|
    road_trip.data[:weather_at_eta]
  end
end