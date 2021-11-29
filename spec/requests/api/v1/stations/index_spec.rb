require 'rails_helper'

RSpec.describe "Search for stations by location" do
  let(:location) { "Denver, CO" }
  let(:body) { JSON.parse(response.body, symbolize_names:true) }
  let(:station1) { body[:data][0][:attributes] }
  let(:blank_location) { " " }
  let(:invalid_location) { "oghkhhohoiho79808707" }

  describe "HAPPY PATH" do
    it "Endpoint exists and has attributes", :vcr do
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
      expect(station1.size).to eq(10)
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
