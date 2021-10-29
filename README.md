# EV Station Finder - Backend
API constructed by aggregating two external APIs to provide charging station information including 10-hour forecast.
This app serves data from [NREL](https://developer.nrel.gov/docs/transportation/alt-fuel-stations-v1/) and [OpenWeather](https://openweathermap.org/api) external APIs.
The current endpoints facilitate access for a guest and registered user.
A user can search nearby stations using various search queries including:
  - zip code
  - full address
  - city and state
A registered user can save stations to their account.
Backend also allows user registration, authentication, and registration.

**Note:** This app is currently being worked on and it is also deployed on [Heroku](https://ev-station-finder-backend.herokuapp.com/api/v1/stations?location=los%20angeles,ca).

### Authors
- Alexander Brueck | [GitHub](https://github.com/brueck1988) | [LinkedIn](https://www.linkedin.com/in/brueck1988/)
- Diana Buffone | [GitHub](https://github.com/Diana20920) |
  [LinkedIn](https://www.linkedin.com/in/dianabuffone/)

## Table of Contents
  - [Built With](#built-with)
  - [Front-End Repo](#front-end-repo)
  - [Getting Started](#getting-started)
  - [Usage](#usage)
  - [Running the tests](#running-the-tests)
  - [Roadmap](#roadmap)
  - [DB Schema](#db-schema)
  - [Endpoints](#endpoints)
  - [Contributing](#contributing)
  - [Acknowledgements](#acknowledgements)

## Built With

* [Ruby on Rails](https://rubyonrails.org)
* [CircleCI](https://github.com/circleci/circleci-docs)
* [Heroku](https://www.heroku.com)

### Gems Used
- [Faraday](https://github.com/lostisland/faraday)
- [Bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)
- [Figaro](https://github.com/laserlemon/figaro)
- [Fast JSON API](https://github.com/Netflix/fast_jsonapi)
- [JWT](https://github.com/jwt/ruby-jwt)
- [RSpec](https://github.com/rspec/rspec-rails)
- [Webmock](https://github.com/bblimke/webmock)
- [VCR](https://github.com/vcr/vcr)


<!-- ## Service Oriented Architecture Diagram -->
## Front-End Repo

- You can find more information about the application at [GitHub Repo](https://github.com/EV-Station-Finder/ev_station_finder_fe)
- Visit the deployed application on [Heroku](https://ev-station-finder-frontend.herokuapp.com/stations?location=denver,co)

### Prerequisites

To run this application you will need
* Ruby 2.5.3 and Rails 5.2.6
* Sign up for an API key at:
  - [NREL](https://developer.nrel.gov/signup/)  
  - [OpenWeather](https://home.openweathermap.org/users/sign_up)
  - [MapQuest](https://developer.mapquest.com/user/register)

## Getting Started

To get a local copy up and running follow these simple steps:
1. Fork this repo
2. Clone your forked repo to your local machine
   ```sh
   git clone <git@github.com:EV-Station-Finder/ev_station_finder_fe.git>
   ```
3. Install gem packages
   ```sh
   bundle install
   ```
4. Install Figaro
   ```sh
   bundle exec figaro install
   ```
6. Setup your API keys in your `config/application.yml` file
   ```ruby
   CHARGER_KEY: <your_api_key>
   WEATHER_KEY: <your_api_key>
   MAPS_KEY: <your_api_key>
   ```

## Usage
   1. Create rails database and migrate
       ```sh
        rails db:{create,migrate}
       ```
   2. Start rails server
       ```sh
       rails s
       ```
   3. Nagivate to `http://localhost:3000/`

## Running the tests
RSpec testing suite is utilized for testing this application.
- Run the RSpec suite to ensure everything is passing as expected
  ```sh
  bundle exec rspec
  ```

## Roadmap
 Coming soon

 <!-- See the [open issues]() for a list of proposed features (and known issues). -->

## DB Schema
Coming soon

## Endpoints
1. Search for stations

  `GET /api/v1/stations`

  ```
  request_body = {
                  "location": "Los Angeles, CA"
                 }
  ```
  **`location` parameter can accept the following:**
      - street, city, state, postal code
      - street, city, state
      - street, postal code
      - postal code
      - city, state

  <details>
  <summary>Example response (returns up to 20 stations)</summary>

  ```
  {
    "data": [
      {
        "id": null,
        "type": "station",
        "attributes": {
            "api_id": 57896,
            "name": "Aiso Street Parking Garage",
            "distance": 0.17641,
            "status": "Available",
            "hours": "24 hours daily",
            "ev_network": "eVgo Network",
            "street_address": "101 Judge John Aiso St",
            "city": "Los Angeles",
            "state": "CA",
            "zip_code": "90012"
          }
      },
      {
        "id": null,
        "type": "station",
        "attributes": {
            "api_id": 578908,
            "name": "Nissan of Downtown Los Angeles",
            "distance": 2.07951,
            "status": "Available",
            "hours": "Dealership business hours",
            "ev_network": "Non-Networked",
            "street_address": "635 W Washington Blvd",
            "city": "Los Angeles",
            "state": "CA",
            "zip_code": "90015"
          }
        }
    ]
  }
  ```
  </details>


2. Station View Page

    `GET /api/v1/stations/:id`
    ```
    request_body = {
                    "api_id": 152283
                   }
    ```

    <details>
    <summary>Example response </summary>

      ```
        { 
         "data": {
            "id": null,
            "type": "stations", 
            "attributes": {
                           "name": "Some Charger", 
                           "api_id": 152087,
                           "status": "Temporary Closed",
                           "hours": "24hrs",
                           "ev_connector_types": ["CHADEMO", "J1772COMBO"],
                           "ev_network": "Tesla",
                           "street_address": "123 Street Ave",
                           "city": "Denver",
                           "state": "CO",
                           "zip_code": "12345",
                           "accepted_payments": [
                                                  "apple_pay", "credit"
                                                 ],
                           "hourly_weather": [{
                                                "time": "1300",
                                                "temperature": "75",
                                                "conditions": "Sunny",
                                                "icon": "10d"
                                              }] # ... 10 hour forecasts
          }
         }
        }
      ```
    </details>


3. Users

    a. `POST /api/v1/users`
      ```
      request_body = {
                      "first_name": "Hari",
                      "last_name": "Seldon",
                      "email": "hari.seldon@foundation.com",
                      "street_address": "123 Planet XYZ",
                      "city": "Jupiter",
                      "state": "UN",
                      "zip_code": "12345",
                      "password": "verysecurepassword"
                     }
      ```
      <details>
      <summary>Example response </summary>

      ```
        { 
         "data": {
            "token": "eyJhbGciOiJIUzI1N/J9.eyJ1c5VyX2lkIjo5N30.Dbrd03NdQJu2Ko_vF8hONHP2Yk-LLJuDc5M2znBa4dI",
            "type": "user", 
         }
        }
      ```
      </details>

    b. `POST /api/v1/sessions`
      ```
      request_body = {
                      "email": "hari.seldon@foundation.com",
                      "password": "verysecurepassword"
                     }
      ```
      <details>
      <summary>Example response </summary>

      ```
        { 
          "data": {
              "token": "eyJhbGciOiJIUzI1N/J9.eyJ1c5VyX2lkIjo5N30.Dbrd03NdQJu2Ko_vF8hONHP2Yk-LLJuDc5M2znBa4dI",
              "type": "user", 
         }
        }
      ```
      </details>

    c. `GET /api/v1/authorize`
      ```
      request_body = {
                      "token": "eyJhbGciOiJIUzI1N/J9.eyJ1c5VyX2lkIjo5N30.Dbrd03NdQJu2Ko_vF8hONHP2Yk-LLJuDc5M2znBa4dI"
                     }
      ```

      <details>
      <summary>Example response </summary>

      ```
        { 
          "data": {
              "token": "eyJhbGciOiJIUzI1N/J9.eyJ1c5VyX2lkIjo5N30.Dbrd03NdQJu2Ko_vF8hONHP2Yk-LLJuDc5M2znBa4dI",
              "type": "user", 
         }
        }
      ```
      </details>

    d. `GET /api/v1/users`
      - Returns user information with the token instead of the ID, and without the user's password digest

      ```
      request_body = {
                      "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyNDd9.hSjNPgNbJdVtlIwtOkKqz1OKLxdmND1rvVbL5iZ7cxE"
                     }
      ```

      <details>
      <summary>Example response </summary>

      ```
        { 
         "data": {
            "id": null,
            "type": "user", 
            "attributes": {
                "first_name": "Hari",
                "last_name": "Seldon",
                "email": "hari.seldon@foundation.com",
                "street_address": "123 Planet XYZ",
                "city": "Jupiter",
                "state": "UN",
                "zip_code": "12345"
                         }
                      }
                    }
      ```
      </details>

    e. `GET /api/v1/favorite_stations`
      - Returns user's favorite stations
      ```
            request_body = {
                            "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyNDd9.hSjNPgNbJdVtlIwtOkKqz1OKLxdmND1rvVbL5iZ7cxE"
                           }
      ```

      <details>
      <summary>Example response </summary>

      ```
      {
        "data": [
          {
            "id": null,
            "type": "station",
            "attributes": {
                "api_id": 57896,
                "name": "Aiso Street Parking Garage",
                "distance": 0.17641,
                "status": "Available",
                "hours": "24 hours daily",
                "ev_network": "eVgo Network",
                "street_address": "101 Judge John Aiso St",
                "city": "Los Angeles",
                "state": "CA",
                "zip_code": "90012"
              }
          },
          {
            "id": null,
            "type": "station",
            "attributes": {
                "api_id": 578908,
                "name": "Nissan of Downtown Los Angeles",
                "distance": 2.07951,
                "status": "Available",
                "hours": "Dealership business hours",
                "ev_network": "Non-Networked",
                "street_address": "635 W Washington Blvd",
                "city": "Los Angeles",
                "state": "CA",
                "zip_code": "90015"
              }
            }
        ]
      }
      ```
      </details>

## Contributing

   Contributions are welcome! And they are **sincerely appreciated**.

   1. Fork the Project
   2. Create your Feature Branch (`git checkout -b feature/<your feature name>`)
   3. Commit your Changes (`git commit -m 'Add some SweetFeature'`)
   4. Push to the Branch (`git push origin feature/<your feature name>`)
   5. Open a Pull Request

## Acknowledgements
Coming soon

**************************************************************************
##### 2021/08/21
**[Back to top](#table-of-contents)**
