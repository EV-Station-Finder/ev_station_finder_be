require 'rails_helper'

RSpec.describe 'Create a Favorite Station' do
  let!(:user1) { User.create(first_name: 'Bill',
                              last_name: 'Seldon',
                              email: 'email@example.com',
                              street_address: '2954 Virginia Beach Boulevard',
                              city: 'Virginia Beach',
                              state: 'Virginia',
                              zip_code: '23452',
                              password: 'verysecurepassword') }
  let!(:station1) { Station.create!(api_id: "152087") }
  let!(:station2) { Station.create!(api_id: "152070") }
  let(:token1) { JWT.encode({user_id: user1.id}, 'hasselhoff', 'HS256') }
  let(:headers) { {CONTENT_TYPE: "application/json",
                  ACCEPT: "application/json"} }
  let(:params1) { {token: token1, api_id: 198643} }
  let(:params2) { {token: token1, api_id: 152087} }

  describe 'HAPPY PATH' do
    it 'Endpoint can save station for user' do
      post "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params1)
      body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to be_successful
      expect(body).to have_key(:data)
      expect(body[:data]).to be_a Hash
      expect((body[:data]).size).to eq(1)
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to eq("favorite_station")
    end

    it 'favorite station is added successfully if station already exists in the database' do
      post "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params2)
      body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to be_successful
      expect(body).to have_key(:data)
      expect(body[:data]).to be_a Hash
      expect((body[:data]).size).to eq(1)
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to eq("favorite_station")
    end
  end

  describe 'SAD PATH' do
    let(:params_with_empty_api_id) { {token: token1, api_id: ''} }
    it 'does not save a favorite station twice for the same user' do
      post "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params1)
      post "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params1)
      body = JSON.parse(response.body, symbolize_names:true)

      expect(response.status).to eq(422)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("User has already favorited station with api ID: #{params1[:api_id]}")
    end

    it 'validation fails if an api ID is not provided' do
      post "/api/v1/favorite_stations", headers: headers, params: JSON.generate(params_with_empty_api_id)
      body = JSON.parse(response.body, symbolize_names:true)

      expect(response.status).to eq(400)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Validation failed: Api can't be blank")
    end
  end
end
