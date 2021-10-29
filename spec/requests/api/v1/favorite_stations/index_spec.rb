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
    it "Endpoint exists and has attributes" do #TODO , :vcr
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
    xit "User saved address has no nearby stations" do #TODO add VCR back , :vcr
      user2 =  User.create!(first_name: 'Bill',
                            last_name: 'Seldon',
                            email: 'email1@example.com',
                            street_address: "1712 Av Circunvalacion",
                            city: "Cochabamba",
                            state: "Bolivia",
                            zip_code: '11111',
                            password: 'verysecurepassword')
      user_station3 = UserStation.create!(user_id: user2.id, station_id: station1.id)
      user_station4 = UserStation.create!(user_id: user2.id, station_id: station2.id)
      token2 = JWT.encode({user_id: user2.id}, 'hasselhoff', 'HS256')
      params2 = {token: token2}
      get "/api/v1/dashboard", headers: headers, params: params2
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("dashboard")

      attributes = body[:data][:attributes]

      expect(attributes).to be_a Hash
      expect(attributes.size).to eq(3) #
      expect(attributes).to have_key(:user)
      expect(attributes).to have_key(:nearest_stations)
      expect(attributes).to have_key(:favorite_stations)

      user_object = attributes[:user]

      expect(user_object).to be_a Hash
      expect(user_object).to have_key(:token)
      expect(user_object).to have_key(:email)
      expect(user_object).to have_key(:street_address)
      expect(user_object).to have_key(:city)
      expect(user_object).to have_key(:state)
      expect(user_object).to have_key(:zip_code)

      nearest_stations = attributes[:nearest_stations]

      expect(nearest_stations).to eq([])

      favorite_stations = attributes[:favorite_stations]

      expect(favorite_stations).to be_an Array
      expect(favorite_stations.size).to eq(2)
      expect(favorite_stations[0]).to have_key(:name)
      expect(favorite_stations[0]).to have_key(:api_id)
      expect(favorite_stations[0]).to have_key(:distance)
      expect(favorite_stations[0]).to have_key(:status)
      expect(favorite_stations[0]).to have_key(:hours)
      expect(favorite_stations[0]).to have_key(:ev_network)
      expect(favorite_stations[0]).to have_key(:street_address)
      expect(favorite_stations[0]).to have_key(:city)
      expect(favorite_stations[0]).to have_key(:state)
      expect(favorite_stations[0]).to have_key(:zip_code)
    end

    xit "User saved address is not valid", :vcr do
      user2 =  User.create!(first_name: 'Bill',
                            last_name: 'Seldon',
                            email: 'email2@example.com',
                            street_address: "hfjflkdn",
                            city: "sdhddkndfk",
                            state: "fnnflasjm",
                            zip_code: 'nkfnkdnfsd',
                            password: 'verysecurepassword')
      user_station3 = UserStation.create!(user_id: user2.id, station_id: station1.id)
      user_station4 = UserStation.create!(user_id: user2.id, station_id: station2.id)
      token2 = JWT.encode({user_id: user2.id}, 'hasselhoff', 'HS256')
      params2 = {token: token2}
      get "/api/v1/dashboard", headers: headers, params: params2
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("dashboard")

      attributes = body[:data][:attributes]

      expect(attributes).to be_a Hash
      expect(attributes.size).to eq(3) #
      expect(attributes).to have_key(:user)
      expect(attributes).to have_key(:nearest_stations)
      expect(attributes).to have_key(:favorite_stations)

      user_object = attributes[:user]

      expect(user_object).to be_a Hash
      expect(user_object).to have_key(:token)
      expect(user_object).to have_key(:email)
      expect(user_object).to have_key(:street_address)
      expect(user_object).to have_key(:city)
      expect(user_object).to have_key(:state)
      expect(user_object).to have_key(:zip_code)

      nearest_stations = attributes[:nearest_stations]

      expect(nearest_stations).to eq([])

      favorite_stations = attributes[:favorite_stations]

      expect(favorite_stations).to be_an Array
      expect(favorite_stations.size).to eq(2)
      expect(favorite_stations[0]).to have_key(:name)
      expect(favorite_stations[0]).to have_key(:api_id)
      expect(favorite_stations[0]).to have_key(:distance)
      expect(favorite_stations[0]).to have_key(:status)
      expect(favorite_stations[0]).to have_key(:hours)
      expect(favorite_stations[0]).to have_key(:ev_network)
      expect(favorite_stations[0]).to have_key(:street_address)
      expect(favorite_stations[0]).to have_key(:city)
      expect(favorite_stations[0]).to have_key(:state)
      expect(favorite_stations[0]).to have_key(:zip_code)
    end

    xit "User does not have favorite stations", :vcr do
      user2 =  User.create!(first_name: 'Bill',
                            last_name: 'Seldon',
                            email: 'email3@example.com',
                            street_address: '2954 Virginia Beach Boulevard',
                            city: 'Virginia Beach',
                            state: 'Virginia',
                            zip_code: '23452',
                            password: 'verysecurepassword')
      token2 = JWT.encode({user_id: user2.id}, 'hasselhoff', 'HS256')
      params2 = {token: token2}

      get "/api/v1/dashboard", headers: headers, params: params2
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("dashboard")

      attributes = body[:data][:attributes]

      expect(attributes).to be_a Hash
      expect(attributes.size).to eq(3) #
      expect(attributes).to have_key(:user)
      expect(attributes).to have_key(:nearest_stations)
      expect(attributes).to have_key(:favorite_stations)

      user_object = attributes[:user]

      expect(user_object).to be_a Hash
      expect(user_object).to have_key(:token)
      expect(user_object).to have_key(:email)
      expect(user_object).to have_key(:street_address)
      expect(user_object).to have_key(:city)
      expect(user_object).to have_key(:state)
      expect(user_object).to have_key(:zip_code)

      nearest_stations = attributes[:nearest_stations]

      expect(nearest_stations).to be_an Array
      expect(nearest_stations.size).to eq(3)
      expect(nearest_stations[0]).to have_key(:name)
      expect(nearest_stations[0]).to have_key(:api_id)
      expect(nearest_stations[0]).to have_key(:distance)
      expect(nearest_stations[0]).to have_key(:status)
      expect(nearest_stations[0]).to have_key(:hours)
      expect(nearest_stations[0]).to have_key(:ev_network)
      expect(nearest_stations[0]).to have_key(:street_address)
      expect(nearest_stations[0]).to have_key(:city)
      expect(nearest_stations[0]).to have_key(:state)
      expect(nearest_stations[0]).to have_key(:zip_code)

      favorite_stations = attributes[:favorite_stations]

      expect(favorite_stations).to eq([])
    end
  end
end
