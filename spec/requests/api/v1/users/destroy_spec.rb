require 'rails_helper'

RSpec.describe "Destroy user" do
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
    it "User is destroyed", :vcr do
      delete "/api/v1/users", headers: headers, params: JSON.generate(params1)

      expect(response).to be_successful
      expect(response).to have_http_status(204)
    end
  end

  describe "Sad Path/Edge Cases" do
    it "User does not exist", :vcr do
      token2 = JWT.encode({user_id: 899}, 'hasselhoff', 'HS256')
      params2 = {token: token2}
      
      delete "/api/v1/users", headers: headers, params: JSON.generate(params2)
      
      body = JSON.parse(response.body, symbolize_names:true)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("User not found")
    end

    it "Token is invalid", :vcr do
      altered_token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.dU5lpMZtX69nehQPn0j23AApFaC8LW-dNuPSw9hH4cY"
      params2 = {token: altered_token}
      
      delete "/api/v1/users", headers: headers, params: JSON.generate(params2)
      
      body = JSON.parse(response.body, symbolize_names:true)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
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

      delete "/api/v1/users", headers: headers, params: JSON.generate(params2)
      
      body = JSON.parse(response.body, symbolize_names:true)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end
  end
end
