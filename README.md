# Whether Sweather
This is a backend application that was the final solo project for the third module in Turing's Backend program. This application allows users to create a user, login as that user, get forecasts for a given location, and create roadtrips with forecast data at the destination for the estimated time of arrival. 

## Learning goals
In the process of creating this application: 
- I exposed an API enpoint that aggregated data from several external API's (namely https://timezonedb.com/, https://developer.mapquest.com/, https://www.weatherapi.com/)
- Created a validation of an API key given at user creation and used during roadtrip creation 
- Exposed this backend API to perform CRUD functions 
- Developed based on wireframes provided by an imaginary frontend team (https://backend.turing.edu/module3/projects/sweater_weather/requirements)
- Tested the exposure of the API through the gem VCR (https://github.com/vcr/vcr) and Webmock (https://github.com/bblimke/webmock)

## Use and Operation 
Steps: 
1. Clone the repository locally 
```
git clone git@github.com:andrew-bingham1/whether_sweater.git
```
2. Run 'bundle install' to install gems
3. Set up database
```
rails db:drop
rails db:create
rails db:migrate
```
4. Signup for API keys at the following locations
- https://timezonedb.com/
- https://developer.mapquest.com/
- https://www.weatherapi.com/
5. Install Figaro
```
bundle exec install figaro
```
This will create an application.yml file where you will need to encode your API keys like so:
```
MAPQUEST_API_KEY: 'your key here'
WEATHER_API_KEY: 'your key here'
TIMEZONE_API_KEY: 'your key here'
```

6. Run the `bundle exec rspec` command to see all of the Rspec tests run and ensure the program is running properly.
7. Run 'rails s' to spin up the application locally 

## Endpoints
Once everything above is finished the following API endpoints are available: 

**1. Get a forecast**

**Request:**
```
GET /api/v0/forecast?location=cincinatti,oh
Content-Type: application/json
Accept: application/json
```
**Response:**
```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-04-07 16:30",
        "temperature": 55.0,
        etc
      },
      "daily_weather": [
        {
          "date": "2023-04-07",
          "sunrise": "07:13 AM",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00",
          "temperature": 54.5,
          etc
        },
        {...} etc
      ]
    }
  }
}
```

**2. Create a user**

**Request:**
```
POST /api/v0/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
**Response:**
```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
**3. Create a session**

**Request:**
```
POST /api/v0/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```
**Response:**
```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
**4. Create a roadtrip**

**Request:**
```
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
}
```
**Response:**
```
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-07 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}
```
