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
  # let(:token3) { JWT.encode({user_id: 899}, 'hasselhoff', 'HS256') } # user does not exist
  # let(:params3) { {token: token3} }
  # let(:altered_token) { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.dU5lpMZtX69nehQPn0j23AApFaC8LW-dNuPSw9hH4cY" }
  # let(:params4) { {token: altered_token} }
  # let(:params5) { {token: ""} }
  # let(:params_with_empty_api_id) { {token: token1, api_id: ''} }

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
  end
  
  it 'User token is not valid', :vcr do
  end
  
  it 'API ID is not provided', :vcr do
  end
  
  it 'API ID is not valid', :vcr do
  end
  
  it 'Favorited station does not exist for user', :vcr do
  end

    # it 'User has already unfavorited station', :vcr do
  #   #   post "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params1)
  #   #   post "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params1)
  #   # 
  #   #   expect(response.status).to eq(422)
  #   #   expect(body).to have_key(:errors)
  #   #   expect(body[:errors]).to eq("User has already favorited station with api ID: #{params1[:api_id]}")
  #   # end
  #   # 
    # it 'validation fails if an api ID is not provided', :vcr do
  #   #   post "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params_with_empty_api_id)
  #   # 
  #   #   expect(response.status).to eq(400)
  #   #   expect(body).to have_key(:errors)
  #   #   expect(body[:errors]).to eq("Validation failed: Api can't be blank")
  #   # end
  end
end
