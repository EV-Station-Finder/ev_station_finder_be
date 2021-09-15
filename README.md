# EV Station Finder - Backend
Description/general information coming soon

### Authors
- Alexander Brueck | [GitHub](https://github.com/brueck1988) | [LinkedIn](https://www.linkedin.com/in/brueck1988/)
- Diana Buffone | [GitHub](https://github.com/Diana20920) |
  [LinkedIn](https://www.linkedin.com/in/dianabuffone/)

## Table of Contents
  - [Built With](#built-with)
  - [Getting Started](#getting-started)
  - [Usage](#usage)
  - [Running the tests](#running-the-tests)
  - [Roadmap](#roadmap)
  - [DB Schema](#db-schema)
  - [Endpoints](#endpoints)
  - [Contributing](#contributing)
  - [Acknowledgements](#acknowledgements)

## Learning Goals
Coming soon

## Built With

* [Ruby on Rails](https://rubyonrails.org)

### Gems Used
- [Faraday](https://github.com/lostisland/faraday)
- [Bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)
- [Figaro](https://github.com/laserlemon/figaro)
- [Travis](https://github.com/travis-ci/travis.rb)
- [Webmock](https://github.com/bblimke/webmock)
- [VCR](https://github.com/vcr/vcr)


<!-- ## Service Oriented Architecture Diagram -->
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

  `GET /api/v1/stations?location=denver,co`

  ```json
  request_body = {
                  "location": "Denver,CO (or zip code)"
                 }
  ```

  <details>
  <summary>Example response </summary>

  ```json
    {
      "data": {
          "id": null,
          "type": "stations",
          "attributes":[{
                          "name": "Denver Supercharger",
                          "api_id": 152087,
                          "distance": 1.7,
                          "status": "Open",
                          "hours": "9-5, M-F",
                          "ev_network": "Tesla",
                          "street_address": "1456 Smith Road",
                          "city": "Denver",
                          "state": "CO",
                          "zip_code": "80289"
                        },
                        {
                          "name": "Golden Supercharger",
                          "api_id": 252687,
                          "distance": 8.7,
                          "status": "Open",
                          "hours": "9-5, M-F",
                          "ev_network": "Tesla",
                          "street_address": "1456 Smith Road",
                          "city": "Golden",
                          "state": "CO",
                          "zip_code": "80401"
                        },
                        ....up to 20 results
                      ]
              }
    }
  ```
  </details>


2. Station View Page

    `GET /api/v1/stations/:id`
    ```json
    request_body = {
                    "api_id": 152283
                   }
    ```

    <details>
    <summary>Example response </summary>

  ```json
    { 
     "data": {
        "id": null,
        "type": "stations", 
        "attributes": {
                       "name": "Some Charger", 
                       "api_id": 152087,
                       "status": "Temporary Closed",
                       "hours": "24hrs",
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
