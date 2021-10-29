require 'rails_helper'

RSpec.describe "See a user's favorite stations" do
  let!(:user1) { User.create(first_name: 'Bill',
                              last_name: 'Seldon',
                              email: 'email@example.com',
                              street_address: '2954 Virginia Beach Boulevard',
                              city: 'Virginia Beach',
                              state: 'Virginia',
                              zip_code: '23452',
                              password: 'verysecurepassword') }
  let(:station1) { Station.create!(api_id: "152087") }
  let(:station2) { Station.create!(api_id: "152070") }
  let!(:user_station1) { UserStation.create!(user_id: user1.id, station_id: station1.id) }
  let!(:user_station2) { UserStation.create!(user_id: user1.id, station_id: station2.id) }
  let(:token1) { JWT.encode({user_id: user1.id}, 'hasselhoff', 'HS256') }
  let(:headers) { {CONTENT_TYPE: "application/json",
                  ACCEPT: "application/json"} }
  let(:params1) { {token: token1} }

  describe "Happy Path" do
    it "Endpoint exists and has attributes", :vcr do
      get "/api/v1/favorite_stations", headers: headers, params: params1

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:data)
      expect(body[:data]).to be_an Array
      expect((body[:data]).size).to eq(2)
      expect(body[:data][0]).to have_key(:id)
      expect(body[:data][0]).to have_key(:type)
      expect(body[:data][0][:type]).to eq("station")

      favorite_station = body[:data][0][:attributes]

      expect(favorite_station).to have_key(:name)
      expect(favorite_station).to have_key(:api_id)
      expect(favorite_station).to have_key(:distance)
      expect(favorite_station).to have_key(:status)
      expect(favorite_station).to have_key(:hours)
      expect(favorite_station).to have_key(:ev_network)
      expect(favorite_station).to have_key(:street_address)
      expect(favorite_station).to have_key(:city)
      expect(favorite_station).to have_key(:state)
      expect(favorite_station).to have_key(:zip_code)
    end
  end

  describe "Sad Path/Edge Cases" do
    it "User does not have favorite stations", :vcr do
      user2 =  User.create!(first_name: 'Bill',
                            last_name: 'Seldon',
                            email: 'email1@example.com',
                            street_address: "1712 Av Circunvalacion",
                            city: "Cochabamba",
                            state: "Bolivia",
                            zip_code: '11111',
                            password: 'verysecurepassword')
      token2 = JWT.encode({user_id: user2.id}, 'hasselhoff', 'HS256')
      params2 = {token: token2}
      get "/api/v1/favorite_stations", headers: headers, params: params2


      body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("User has no favorite stations")
    end

    it "User does not exist", :vcr do

      token2 = JWT.encode({user_id: 899}, 'hasselhoff', 'HS256')
      params2 = {token: token2}
      get "/api/v1/favorite_stations", headers: headers, params: params2
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      body = JSON.parse(response.body, symbolize_names:true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("User not found")
    end

    it "Token is invalid", :vcr do
      altered_token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.dU5lpMZtX69nehQPn0j23AApFaC8LW-dNuPSw9hH4cY"
      params2 = {token: altered_token}
      get "/api/v1/favorite_stations", headers: headers, params: params2
      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      body = JSON.parse(response.body, symbolize_names:true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end

    it "Token is empty or not sent", :vcr do
      user2 =  User.create!(first_name: 'Bill',
                            last_name: 'Seldon',
                            email: 'email3@example.com',
                            street_address: '2954 Virginia Beach Boulevard',
                            city: 'Virginia Beach',
                            state: 'Virginia',
                            zip_code: '23452',
                            password: 'verysecurepassword')
      params2 = {token: ""}

      get "/api/v1/favorite_stations", headers: headers, params: params2
      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      body = JSON.parse(response.body, symbolize_names:true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end
  end
end
