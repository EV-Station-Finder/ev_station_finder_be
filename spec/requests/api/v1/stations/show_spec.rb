require 'rails_helper'

RSpec.describe "Display a single station" do
  let(:api_id) { 152087 }
  let(:api_id_is_zero) { 0 }
  let(:api_id_does_not_exist) { 8393939300393 }
  let(:invalid_api_id) { "dhshdh" }
  let(:blank_api_id) {  } # used to be api_id = " "
  let(:response_body) { JSON.parse(response.body, symbolize_names: true) }
  let(:new_station) { response_body[:data][:attributes] }
  let(:accepted_payments) { new_station[:accepted_payments] }
  let(:hourly_weather) { new_station[:hourly_weather] }

  describe "HAPPY PATH" do
    it "Endpoint exists and has attributes", :vcr do
      get "/api/v1/stations/#{api_id}"

      expect(response).to have_http_status(:ok)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:id]).to eq(nil)
      expect(response_body[:data][:type]).to be_a String
      expect(response_body[:data][:attributes]).to be_a Hash

      expect(new_station).to have_key(:name)
      expect(new_station).to have_key(:api_id)
      expect(new_station).to have_key(:status)
      expect(new_station).to have_key(:hours)
      expect(new_station).to have_key(:ev_network)
      expect(new_station).to have_key(:street_address)
      expect(new_station).to have_key(:city)
      expect(new_station).to have_key(:state)
      expect(new_station).to have_key(:zip_code)
      expect(new_station).to have_key(:accepted_payments)
      expect(new_station).to have_key(:hourly_weather)

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

    xit "ID is blank", :vcr do
      # Used to get this error:
        # URI::InvalidURIError:
        # bad URI(is not URI?): http://www.example.com:80/api/v1/stations/
      # Because we were passing a string, but if we pass a blank field it redirects to the stations index and then
      # returns an error message that a location must be provided. One thing we can try is reordering the stations routes?
      get "/api/v1/stations/#{blank_api_id}"

      expect(response).to have_http_status(:bad_request)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to be_a String
      expect(body[:errors]).to eq("Cannot find station with ID #{api_id}") # Change?: "...without an ID"
    end
  end
end
