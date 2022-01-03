require 'rails_helper'

RSpec.describe "Stations Index - Search for stations by location" do
  let(:location) { "Denver, CO" }
  let(:body) { JSON.parse(response.body, symbolize_names:true) }
  let(:blank_location) { " " }
  let(:invalid_location) { "oghkhhohoiho79808707" }
  
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
                              
  let(:station1) { body[:data][0][:attributes] }
  let(:denver_station1) { Station.create!(api_id: "198643") }
  let(:denver_station2) { Station.create!(api_id: "50066") }
  let!(:user_station1) { UserStation.create!(user_id: user1.id, station_id: denver_station1.id) }
  let!(:user_station2) { UserStation.create!(user_id: user1.id, station_id: denver_station2.id) }
  let(:token1) { JWT.encode({user_id: user1.id}, 'hasselhoff', 'HS256') }
  let(:token2) { JWT.encode({user_id: user2.id}, 'hasselhoff', 'HS256') }
  let(:headers) { {CONTENT_TYPE: "application/json",
                  ACCEPT: "application/json"} }
                  
  let(:params1) { {location: location, token: token1} }
  let(:params2) { {location: location, token: token2} }
  let(:token3) { JWT.encode({user_id: 899}, 'hasselhoff', 'HS256') } # user does not exist
  let(:params3) { {token: token3} }
  let(:altered_token) { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.dU5lpMZtX69nehQPn0j23AApFaC8LW-dNuPSw9hH4cY" }
  let(:params4) { {token: altered_token} }
  let(:params5) { {token: ""} }

  describe "HAPPY PATH" do
    it "GUEST USER - Endpoint exists and has attributes", :vcr do
      get "/api/v1/stations?location=#{location}"

      expect(response).to be_successful

      expect(body).to have_key(:data)
      expect(body[:data][0]).to have_key(:id)
      expect(body[:data][0]).to have_key(:type)
      expect(body[:data][0]).to have_key(:attributes)
      expect(body[:data][0][:id]).to eq(nil)
      expect(body[:data][0][:type]).to be_a String
      expect(body[:data][0][:type]).to eq("station")
      expect(body[:data][0][:attributes]).to be_a Hash
      expect(body[:data].size).to be < 21

      expect(station1).to be_a Hash
      expect(station1.size).to eq(11)
      expect(station1).to have_key(:api_id)
      expect(station1).to have_key(:name)
      expect(station1).to have_key(:distance)
      expect(station1).to have_key(:status)
      expect(station1).to have_key(:hours)
      expect(station1).to have_key(:ev_network)
      expect(station1).to have_key(:street_address)
      expect(station1).to have_key(:city)
      expect(station1).to have_key(:state)
      expect(station1).to have_key(:zip_code)
      expect(station1).to have_key(:is_favorited)
    end
    
    it "LOGGED IN USER WITH FAVORITE STATIONS - Endpoint exists and has attributes", :vcr do
      get "/api/v1/stations", headers: headers, params: params1

      expect(response).to be_successful
      
      expect(body).to have_key(:data)
      expect(body[:data][0]).to have_key(:id)
      expect(body[:data][0]).to have_key(:type)
      expect(body[:data][0]).to have_key(:attributes)
      expect(body[:data][0][:id]).to eq(nil)
      expect(body[:data][0][:type]).to be_a String
      expect(body[:data][0][:type]).to eq("station")
      expect(body[:data].size).to be < 21

      expect(station1).to be_a Hash
      expect(station1.size).to eq(11)
      expect(station1).to have_key(:api_id)
      expect(station1).to have_key(:name)
      expect(station1).to have_key(:distance)
      expect(station1).to have_key(:status)
      expect(station1).to have_key(:hours)
      expect(station1).to have_key(:ev_network)
      expect(station1).to have_key(:street_address)
      expect(station1).to have_key(:city)
      expect(station1).to have_key(:state)
      expect(station1).to have_key(:zip_code)
      expect(station1).to have_key(:is_favorited)
    end
    
    it "LOGGED IN USER WITHOUT FAVORITE STATIONS - Endpoint exists and has attributes", :vcr do
      get "/api/v1/stations", headers: headers, params: params2

      expect(response).to be_successful
      
      expect(body).to have_key(:data)
      expect(body[:data][0]).to have_key(:id)
      expect(body[:data][0]).to have_key(:type)
      expect(body[:data][0]).to have_key(:attributes)
      expect(body[:data][0][:id]).to eq(nil)
      expect(body[:data][0][:type]).to be_a String
      expect(body[:data][0][:type]).to eq("station")
      expect(body[:data][0][:attributes]).to be_a Hash
      expect(body[:data].size).to be < 21
      
      expect(station1).to be_a Hash
      expect(station1.size).to eq(11)
      expect(station1).to have_key(:api_id)
      expect(station1).to have_key(:name)
      expect(station1).to have_key(:distance)
      expect(station1).to have_key(:status)
      expect(station1).to have_key(:hours)
      expect(station1).to have_key(:ev_network)
      expect(station1).to have_key(:street_address)
      expect(station1).to have_key(:city)
      expect(station1).to have_key(:state)
      expect(station1).to have_key(:zip_code)
      expect(station1).to have_key(:is_favorited)
    end
  end

  describe "SAD PATH" do
    it "location is not provided", :vcr do
      get "/api/v1/stations"

      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("A valid location must be provided")
    end

    it "location is blank", :vcr do
      get "/api/v1/stations?location=#{blank_location}"

      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("A valid location must be provided")
    end

    it "location is invalid or there are no nearby stations", :vcr do
      get "/api/v1/stations?location=#{invalid_location}"

      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("A valid location must be provided")
    end
    
    it "User does not exist, but location is valid", :vcr do
      get "/api/v1/stations?location=#{location}", headers: headers, params: params3

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("User not found")
    end

    it "User token is invalid, but location is valid", :vcr do
      get "/api/v1/stations?location=#{location}", headers: headers, params: params4

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end

    it "User token is empty, but location is valid", :vcr do
      get "/api/v1/stations?location=#{location}", headers: headers, params: params5
 
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body[:data][0][:attributes]).to be_a Hash
      expect(station1).to have_key(:is_favorited)
      expect(station1[:is_favorited]).to eq("User token not provided")
    end
  end
end
