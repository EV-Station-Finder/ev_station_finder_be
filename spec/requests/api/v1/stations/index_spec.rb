require 'rails_helper'

RSpec.describe "Stations Index - Search for stations by location and provide favorite stations if applicable" do
  let(:location) { "Denver, CO" }
  let(:body) { JSON.parse(response.body, symbolize_names:true) }
  let(:station1) { body[:data][0][:attributes] }
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
  let(:denver_station1) { Station.create!(api_id: "198643") }
  let(:denver_station2) { Station.create!(api_id: "50066") }
  let!(:user_station1) { UserStation.create!(user_id: user1.id, station_id: denver_station1.id) }
  let!(:user_station2) { UserStation.create!(user_id: user1.id, station_id: denver_station2.id) }
  let(:token1) { JWT.encode({user_id: user1.id}, 'hasselhoff', 'HS256') }
  let(:headers) { {CONTENT_TYPE: "application/json",
                  ACCEPT: "application/json"} }
  let(:params1) { {location: location, token: token1} }

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
    
    xit "LOGGED IN USER WITH FAVORITE STATIONS - Endpoint exists and has attributes" do # TODO ADD , :vcr
      get "/api/v1/stations", headers: headers, params: params1

      # expect(response).to be_successful
      # 
      # expect(body).to have_key(:data)
      # expect(body[:data][0]).to have_key(:id)
      # expect(body[:data][0]).to have_key(:type)
      # expect(body[:data][0]).to have_key(:attributes)
      # expect(body[:data][0][:id]).to eq(nil)
      # expect(body[:data][0][:type]).to be_a String
      # expect(body[:data][0][:type]).to eq("station")
      # expect(body[:data][0][:attributes]).to be_a Hash
      # expect(body[:data].size).to be < 21
      # 
      # expect(station1).to be_a Hash
      # expect(station1.size).to eq(10)
      # expect(station1).to have_key(:api_id)
      # expect(station1).to have_key(:name)
      # expect(station1).to have_key(:distance)
      # expect(station1).to have_key(:status)
      # expect(station1).to have_key(:hours)
      # expect(station1).to have_key(:ev_network)
      # expect(station1).to have_key(:street_address)
      # expect(station1).to have_key(:city)
      # expect(station1).to have_key(:state)
      # expect(station1).to have_key(:zip_code)
    end
    
    xit "LOGGED IN USER WITHOUT FAVORITE STATIONS - Endpoint exists and has attributes", :vcr do
      # get "/api/v1/stations?location=#{location}"
      # 
      # expect(response).to be_successful
      # 
      # expect(body).to have_key(:data)
      # expect(body[:data][0]).to have_key(:id)
      # expect(body[:data][0]).to have_key(:type)
      # expect(body[:data][0]).to have_key(:attributes)
      # expect(body[:data][0][:id]).to eq(nil)
      # expect(body[:data][0][:type]).to be_a String
      # expect(body[:data][0][:type]).to eq("station")
      # expect(body[:data][0][:attributes]).to be_a Hash
      # expect(body[:data].size).to be < 21
      # 
      # expect(station1).to be_a Hash
      # expect(station1.size).to eq(10)
      # expect(station1).to have_key(:api_id)
      # expect(station1).to have_key(:name)
      # expect(station1).to have_key(:distance)
      # expect(station1).to have_key(:status)
      # expect(station1).to have_key(:hours)
      # expect(station1).to have_key(:ev_network)
      # expect(station1).to have_key(:street_address)
      # expect(station1).to have_key(:city)
      # expect(station1).to have_key(:state)
      # expect(station1).to have_key(:zip_code)
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
  end
end
