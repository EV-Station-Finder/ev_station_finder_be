require 'rails_helper'

RSpec.describe "Show user information" do
  let!(:user1) { User.create(first_name: 'Bill',
                              last_name: 'Seldon',
                              email: 'email@example.com',
                              street_address: '2954 Virginia Beach Boulevard',
                              city: 'Virginia Beach',
                              state: 'Virginia',
                              zip_code: '23452',
                              password: 'verysecurepassword') }
  let(:token1) { JWT.encode({user_id: user1.id}, 'hasselhoff', 'HS256') }
  let(:headers) { {CONTENT_TYPE: "application/json",
                  ACCEPT: "application/json"} }
  let(:params1) { {token: token1} }

  describe "Happy Path" do
    it "Endpoint exists and has attributes", :vcr do
      get "/api/v1/users", headers: headers, params: params1

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names:true)
      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("user")

      attributes = body[:data][:attributes]

      expect(attributes).to be_a Hash
      expect(attributes.size).to eq(7)
      expect(attributes).to have_key(:first_name)
      expect(attributes).to have_key(:last_name)
      expect(attributes).to have_key(:email)
      expect(attributes).to have_key(:street_address)
      expect(attributes).to have_key(:city)
      expect(attributes).to have_key(:state)
      expect(attributes).to have_key(:zip_code)
    end
  end

  describe "Sad Path/Edge Cases" do
    it "User does not exist", :vcr do
    
      token2 = JWT.encode({user_id: 899}, 'hasselhoff', 'HS256')
      params2 = {token: token2}
      get "/api/v1/users", headers: headers, params: params2
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      
      body = JSON.parse(response.body, symbolize_names:true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("User not found")
    end

    it "Token is invalid", :vcr do
      altered_token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.dU5lpMZtX69nehQPn0j23AApFaC8LW-dNuPSw9hH4cY"
      params2 = {token: altered_token}
      get "/api/v1/users", headers: headers, params: params2
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

      get "/api/v1/users", headers: headers, params: params2
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      
      body = JSON.parse(response.body, symbolize_names:true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end
  end
end
