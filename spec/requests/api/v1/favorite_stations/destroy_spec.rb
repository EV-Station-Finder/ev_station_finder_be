require 'rails_helper'

RSpec.describe 'Destroy a Favorite Station' do
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
  let(:params1) { {token: token1, api_id: station1.api_id} }
  let(:body) { JSON.parse(response.body, symbolize_names:true) }
  
  # # SAD PATH/EDGE CASES:
  let(:params2) { {token: "", api_id: station1.api_id} }
  let(:altered_token) { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.dU5lpMZtX69nehQPn0j23AApFaC8LW-dNuPSw9hH4cY" }
  let(:params3) { {token: altered_token, api_id: station1.api_id} }
  let(:token4) { JWT.encode({user_id: 899}, 'hasselhoff', 'HS256') } # user does not exist
  let(:params4) { {token: token4, api_id: station1.api_id} }

  describe 'HAPPY PATH' do
    it 'Favorite station is removed successfully for a user', :vcr do
      expect(user_station1.favorited?).to eq(true)
      
      delete "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params1)

      user_station = UserStation.find_by(station_id: station1.id, user_id: user1.id)
      expect(response).to be_successful
      expect(response).to have_http_status(204)
      expect(user_station.favorited?).to eq(false)
    end
  end

  describe 'SAD PATH' do
    it 'User has already unfavorited station', :vcr do
      user_station2.update!(favorited?: false)
      user_station = UserStation.find_by(user_id: user1.id, station_id: station2.id)
      expect(user_station.favorited?).to eq(false)
      params = {token: token1, api_id: station2.api_id}
      
      delete "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Favorite station not found")
    end
    
    it 'User token is not provided', :vcr do
      delete "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params2)
    
      expect(response.status).to eq(401)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end
    
    it 'User token is not valid', :vcr do
      delete "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params3)

      expect(response.status).to eq(401)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end
    
    it 'User does not exist', :vcr do
      delete "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params4)

      expect(response.status).to eq(404)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("UserStation not found")
    end
    
    it 'API ID is not provided', :vcr do
    end
    
    it 'API ID is not valid', :vcr do
    end
    
    it 'Favorited station does not exist for user', :vcr do
    end
  end
end
