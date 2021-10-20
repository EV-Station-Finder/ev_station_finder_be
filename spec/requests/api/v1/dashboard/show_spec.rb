require 'rails_helper'

RSpec.describe "See a user's dashboard page information" do
  let!(:user) { FactoryBot.create(:user, first_name: 'Bill',
                                        last_name: 'Seldon',
                                        email: 'email@example.com',
                                        street_address: '2954 Virginia Beach Boulevard',
                                        city: 'Virginia Beach',
                                        state: 'Virginia',
                                        zip_code: '23452',
                                        password: 'verysecurepassword') }
  let(:token) { JWT.encode({user_id: user.id}, 'hasselhoff', 'HS256') }
  let(:headers) { {CONTENT_TYPE: "application/json",
                  ACCEPT: "application/json"} }
  let(:params) { {token: token} }

  describe "Happy Path" do
    it "Endpoint exists and has attributes", :vcr do
# binding.pry
      get "/api/v1/dashboard", headers: headers, params: params

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

      user = attributes[:user]

      expect(user).to be_a Hash
      expect(user).to have_key(:token)
      expect(user).to have_key(:email)
      expect(user).to have_key(:street_address)
      expect(user).to have_key(:city)
      expect(user).to have_key(:state)
      expect(user).to have_key(:zip_code)

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

      expect(favorite_stations).to be_an Array
      # expect(favorite_stations[0]).to have_key(:name)
      # expect(favorite_stations[0]).to have_key(:api_id)
      # expect(favorite_stations[0]).to have_key(:distance)
      # expect(favorite_stations[0]).to have_key(:status)
      # expect(favorite_stations[0]).to have_key(:hours)
      # expect(favorite_stations[0]).to have_key(:ev_network)
      # expect(favorite_stations[0]).to have_key(:street_address)
      # expect(favorite_stations[0]).to have_key(:city)
      # expect(favorite_stations[0]).to have_key(:state)
      # expect(favorite_stations[0]).to have_key(:zip_code)
    end
  end

  describe "Sad Path/Edge Cases" do
    xit "location is not provided", :vcr do
      get "/api/v1/stations"
      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("A valid location must be provided")
    end

    xit "location is blank", :vcr do
      location = " "
      get "/api/v1/stations?location=#{location}"
      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("A valid location must be provided")
    end

    xit "location is invalid", :vcr do
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
