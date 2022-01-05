require 'rails_helper'

RSpec.describe "Station Show - Search for a station by api_id" do
  let(:api_id) { 152087 }
  let(:api_id_is_zero) { 0 }
  let(:api_id_does_not_exist) { 8393939300393 }
  let(:invalid_api_id) { "dhshdh" }
  let(:response_body) { JSON.parse(response.body, symbolize_names: true) }
  let(:new_station) { response_body[:data][:attributes] }
  let(:accepted_payments) { new_station[:accepted_payments] }
  let(:hourly_weather) { new_station[:hourly_weather] }
  
  # Create logged in user with favorite stations
  let!(:user1) { User.create(first_name: 'Bill',
                              last_name: 'Seldon',
                              email: 'email@example.com',
                              street_address: '2954 Virginia Beach Boulevard',
                              city: 'Virginia Beach',
                              state: 'Virginia',
                              zip_code: '23452',
                              password: 'verysecurepassword') }
                              
  let!(:user2) { User.create(first_name: 'Mary',
                              last_name: 'Seldon',
                              email: 'mary@example.com',
                              street_address: '2954 Virginia Beach Boulevard',
                              city: 'Virginia Beach',
                              state: 'Virginia',
                              zip_code: '23452',
                              password: 'verysecurepassword') }
                              
  let(:station1) { body[:data][:attributes] }
  let(:denver_station1) { Station.create!(api_id: "198643") }
  let(:denver_station2) { Station.create!(api_id: "50066") }
  let!(:user_station1) { UserStation.create!(user_id: user1.id, station_id: denver_station1.id) }
  let!(:user_station2) { UserStation.create!(user_id: user1.id, station_id: denver_station2.id) }
  let(:token1) { JWT.encode({user_id: user1.id}, 'hasselhoff', 'HS256') }
  let(:token2) { JWT.encode({user_id: user2.id}, 'hasselhoff', 'HS256') }
  let(:headers) { {CONTENT_TYPE: "application/json",
                  ACCEPT: "application/json"} }
                  
  let(:params1) { {token: token1} }
  let(:params2) { {token: token2} }
  let(:token3) { JWT.encode({user_id: 899}, 'hasselhoff', 'HS256') } # user does not exist
  let(:params3) { {token: token3} }
  let(:altered_token) { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.dU5lpMZtX69nehQPn0j23AApFaC8LW-dNuPSw9hH4cY" }
  let(:params4) { {token: altered_token} }
  let(:params5) { {token: ""} }
  let(:params6) { {token: nil} }

  describe "HAPPY PATH" do
    it "GUEST USER - Endpoint exists and has attributes", :vcr do
      get "/api/v1/stations/#{api_id}"

      expect(response).to be_successful

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:id]).to eq(nil)
      expect(response_body[:data][:type]).to be_a String
      expect(response_body[:data][:type]).to eq("station")
      expect(response_body[:data][:attributes]).to be_a Hash

      expect(new_station.size).to eq(13)
      expect(new_station).to have_key(:name)
      expect(new_station).to have_key(:api_id)
      expect(new_station).to have_key(:status)
      expect(new_station).to have_key(:hours)
      expect(new_station).to have_key(:ev_network)
      expect(new_station).to have_key(:ev_connector_types)
      expect(new_station).to have_key(:street_address)
      expect(new_station).to have_key(:city)
      expect(new_station).to have_key(:state)
      expect(new_station).to have_key(:zip_code)
      expect(new_station).to have_key(:accepted_payments)
      expect(new_station).to have_key(:hourly_weather)
      expect(new_station).to have_key(:is_favorited)

      expect(accepted_payments).to be_an Array

      expect(hourly_weather).to be_an Array
      expect(hourly_weather[0]).to be_an Hash
      expect(hourly_weather[0]).to have_key(:time)
      expect(hourly_weather[0]).to have_key(:temperature)
      expect(hourly_weather[0]).to have_key(:conditions)
      expect(hourly_weather[0]).to have_key(:icon)
    end
    
    
    it "LOGGED IN USER WITH FAVORITE STATIONS - Endpoint exists and has attributes", :vcr do
      get "/api/v1/stations/#{denver_station1.api_id}", headers: headers, params: params1

      expect(response).to be_successful

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:id]).to eq(nil)
      expect(response_body[:data][:type]).to be_a String
      expect(response_body[:data][:type]).to eq("station")
      expect(response_body[:data][:attributes]).to be_a Hash

      expect(new_station.size).to eq(13)
      expect(new_station).to have_key(:name)
      expect(new_station).to have_key(:api_id)
      expect(new_station).to have_key(:status)
      expect(new_station).to have_key(:hours)
      expect(new_station).to have_key(:ev_network)
      expect(new_station).to have_key(:ev_connector_types)
      expect(new_station).to have_key(:street_address)
      expect(new_station).to have_key(:city)
      expect(new_station).to have_key(:state)
      expect(new_station).to have_key(:zip_code)
      expect(new_station).to have_key(:accepted_payments)
      expect(new_station).to have_key(:hourly_weather)
      expect(new_station).to have_key(:is_favorited)

      expect(accepted_payments).to be_an Array

      expect(hourly_weather).to be_an Array
      expect(hourly_weather[0]).to be_an Hash
      expect(hourly_weather[0]).to have_key(:time)
      expect(hourly_weather[0]).to have_key(:temperature)
      expect(hourly_weather[0]).to have_key(:conditions)
      expect(hourly_weather[0]).to have_key(:icon)

    end
    
    it "LOGGED IN USER WITHOUT FAVORITE STATIONS - Endpoint exists and has attributes", :vcr do
      get "/api/v1/stations/#{denver_station2.api_id}", headers: headers, params: params2

      expect(response).to be_successful
      
      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:id]).to eq(nil)
      expect(response_body[:data][:type]).to be_a String
      expect(response_body[:data][:type]).to eq("station")
      expect(response_body[:data][:attributes]).to be_a Hash

      expect(new_station.size).to eq(13)
      expect(new_station).to have_key(:name)
      expect(new_station).to have_key(:api_id)
      expect(new_station).to have_key(:status)
      expect(new_station).to have_key(:hours)
      expect(new_station).to have_key(:ev_network)
      expect(new_station).to have_key(:ev_connector_types)
      expect(new_station).to have_key(:street_address)
      expect(new_station).to have_key(:city)
      expect(new_station).to have_key(:state)
      expect(new_station).to have_key(:zip_code)
      expect(new_station).to have_key(:accepted_payments)
      expect(new_station).to have_key(:hourly_weather)
      expect(new_station).to have_key(:is_favorited)
      expect(new_station[:is_favorited]).to eq(false)

      expect(accepted_payments).to be_an Array

      expect(hourly_weather).to be_an Array
      expect(hourly_weather[0]).to be_an Hash
      expect(hourly_weather[0]).to have_key(:time)
      expect(hourly_weather[0]).to have_key(:temperature)
      expect(hourly_weather[0]).to have_key(:conditions)
      expect(hourly_weather[0]).to have_key(:icon)
    end
  end

  describe "SAD PATH" do
    it "ID is 0", :vcr do
      get "/api/v1/stations/#{api_id_is_zero}"

      expect(response).to have_http_status(:bad_request)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to be_a String
      expect(response_body[:errors]).to eq("Cannot find station with ID #{api_id_is_zero}")
    end

    it "ID does not exist", :vcr do
      get "/api/v1/stations/#{api_id_does_not_exist}"

      expect(response).to have_http_status(:bad_request)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to be_a String
      expect(response_body[:errors]).to eq("Cannot find station with ID #{api_id_does_not_exist}")
    end

    it "ID is invalid", :vcr do
      get "/api/v1/stations/#{invalid_api_id}"

      expect(response).to have_http_status(:bad_request)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to be_a String
      expect(response_body[:errors]).to eq("Cannot find station with ID #{invalid_api_id}")
    end
    
    it "User does not exist", :vcr do
      get "/api/v1/stations/#{api_id}", headers: headers, params: params3

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq("User not found")
    end

    it "User token is invalid", :vcr do
      get "/api/v1/stations/#{api_id}", headers: headers, params: params4

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq("Unauthorized")
    end

    it "User token is empty", :vcr do
      get "/api/v1/stations/#{api_id}", headers: headers, params: params5

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response_body[:data][:attributes]).to be_a Hash
      expect(new_station).to have_key(:is_favorited)
      expect(new_station[:is_favorited]).to eq("User token not provided")
    end

    it "User token is nil", :vcr do
      get "/api/v1/stations/#{api_id}", headers: headers, params: params6
      
      expect(response).to be_successful
      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data]).to have_key(:attributes)
    end
  end
end
