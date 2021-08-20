# README

#### Request Format:

`GET /api/v1/stations`
```json
request_body = {
                "location": "Denver,CO (or zip code)"
               }
```
#### Response Format:
```json
response_body = {
                  "data": {
                      "id": null,
                      "type": "stations",
                      "attributes": 
                                  [
                                    {
                                      "name": "Denver Supercharger"
                                          "name": "denver, co",
                                          "distance": 1.7,
                                          "status": "Open",
                                          "ev_charging_level": "Level 1",
                                          "street_address": "1456 Smith Road",
                                          "city": "Denver",
                                          "state": "CO",
                                          "zip_code": "80289"
                                    },
                                    {
                                      "name": "Golden Supercharger"
                                          "name": "golden, co",
                                          "distance": 8.7,
                                          "status": "Open",
                                          "ev_charging_level": "Level 1",
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