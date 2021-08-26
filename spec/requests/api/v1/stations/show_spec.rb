require 'rails_helper'

RSpec.describe "Display a single station" do
  describe "Happy Path" do
    it "Endpoint exists and has attributes" do
      api_id = 152087
      get "/api/v1/stations/#{api_id}"
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to be_a String
      expect(body[:data][:attributes]).to be_a Hash

      new_station = body[:data][:attributes]

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

      accepted_payments = new_station[:accepted_payments]

      expect(accepted_payments).to be_an Array

      hourly_weather = new_station[:hourly_weather]

      expect(hourly_weather).to be_an Array
      expect(hourly_weather[0]).to be_an Hash
      expect(hourly_weather[0]).to have_key(:time)
      expect(hourly_weather[0]).to have_key(:temperature)
      expect(hourly_weather[0]).to have_key(:conditions)
      expect(hourly_weather[0]).to have_key(:icon)
    end
  end
end
