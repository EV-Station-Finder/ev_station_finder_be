require 'rails_helper'

RSpec.describe "Search for stations by location" do
  describe "Happy Path" do
    it "Endpoint exists and has attributes", :vcr do
      location = "Denver, CO"
      get "/api/v1/stations?location=#{location}"
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:data)
      expect(body[:data][0]).to have_key(:id)
      expect(body[:data][0]).to have_key(:type)
      expect(body[:data][0]).to have_key(:attributes)
      expect(body[:data][0][:id]).to eq(nil)
      expect(body[:data][0][:type]).to be_a String
      expect(body[:data][0][:type]).to eq("station")
      expect(body[:data][0][:attributes]).to be_a Hash
      expect(body[:data].size).to be < 21

      station_1 = body[:data][0][:attributes]

      expect(station_1).to be_a Hash
      expect(station_1.size).to eq(10)
      expect(station_1).to have_key(:api_id)
      expect(station_1).to have_key(:name)
      expect(station_1).to have_key(:distance)
      expect(station_1).to have_key(:status)
      expect(station_1).to have_key(:hours)
      expect(station_1).to have_key(:ev_network)
      expect(station_1).to have_key(:street_address)
      expect(station_1).to have_key(:city)
      expect(station_1).to have_key(:state)
      expect(station_1).to have_key(:zip_code)
    end
  end

  describe "Sad Path/Edge Cases" do
    it "location is not provided", :vcr do
      get "/api/v1/stations"
      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("A valid location must be provided")
    end

    it "location is blank", :vcr do
      location = " "
      get "/api/v1/stations?location=#{location}"
      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("A valid location must be provided")
    end

    it "location is invalid or there are no nearby stations", :vcr do
      location = "oghkhhohoiho79808707"
      get "/api/v1/stations?location=#{location}"
      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("A valid location must be provided")
    end
  end
end
