require 'rails_helper'

RSpec.describe "Update user" do
  let!(:user1) { User.create(first_name: 'Bill',
                              last_name: 'Seldon',
                              email: 'email@example.com',
                              street_address: '2954 Virginia Beach Boulevard',
                              city: 'Virginia Beach',
                              state: 'Virginia',
                              zip_code: '23452',
                              password: 'verysecurepassword') }
  let(:user_record) { User.find(user1.id)  }

  let!(:all_new_params) { { first_name: 'William',
                            last_name: 'Seldon Smith',
                            email: 'betteremail@example.com',
                            street_address: '3000 Virginia Beach Boulevard',
                            city: 'Norfolk',
                            state: 'Maryland',
                            zip_code: '22304' } }

  let!(:partially_new_params) { { email: 'workemail@example.com' } }

  let(:token1) { JWT.encode({user_id: user1.id}, 'hasselhoff', 'HS256') }
  let(:headers) { {CONTENT_TYPE: "application/json",
                  ACCEPT: "application/json"} }
  let(:params1) { {token: token1} }
  let(:body) { JSON.parse(response.body, symbolize_names:true) }

  describe "Happy Path" do
    it "All user attributes are updated", :vcr do
      patch "/api/v1/users", headers: headers, params: JSON.generate(all_new_params)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to_not eq(user1.first_name)
      expect(body[:data][:attributes]).to eq(user_record.first_name)
      expect(body[:data][:attributes]).to_not eq(user1.last_name)
      expect(body[:data][:attributes]).to eq(user_record.last_name)
      expect(body[:data][:attributes]).to_not eq(user1.email)
      expect(body[:data][:attributes]).to eq(user_record.email)
      expect(body[:data][:attributes]).to_not eq(user1.street_address)
      expect(body[:data][:attributes]).to eq(user_record.street_address)
      expect(body[:data][:attributes]).to_not eq(user1.city)
      expect(body[:data][:attributes]).to eq(user_record.city)
      expect(body[:data][:attributes]).to_not eq(user1.state)
      expect(body[:data][:attributes]).to eq(user_record.state)
      expect(body[:data][:attributes]).to_not eq(user1.zip_code)
      expect(body[:data][:attributes]).to eq(user_record.zip_code)
    end
    it "Only user email attribute is updated", :vcr do
      patch "/api/v1/users", headers: headers, params: JSON.generate(partially_new_params)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(body[:data][:attributes]).to have_key(:email)
      expect(body[:data][:attributes]).to_not have_key(:first_name)
      expect(body[:data][:attributes]).to_not have_key(:last_name)
      expect(body[:data][:attributes]).to_not have_key(:street_address)
      expect(body[:data][:attributes]).to_not have_key(:city)
      expect(body[:data][:attributes]).to_not have_key(:state)
      expect(body[:data][:attributes]).to_not have_key(:zip_code)
      expect(body[:data][:attributes][:email]).to_not eq(user1.email)
      expect(body[:data][:attributes][:email]).to eq(user_record.email)
    end
  end

  describe "Sad Path/Edge Cases" do
    xit "User does not exist", :vcr do
      token2 = JWT.encode({user_id: 899}, 'hasselhoff', 'HS256')
      params2 = {token: token2}

      patch "/api/v1/users", headers: headers, params: JSON.generate(partially_new_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("User not found")
    end

    xit "Token is invalid", :vcr do
      altered_token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.dU5lpMZtX69nehQPn0j23AApFaC8LW-dNuPSw9hH4cY"
      params2 = {token: altered_token}

      patch "/api/v1/users", headers: headers, params: JSON.generate(partially_new_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end

    xit "Token is empty or not sent", :vcr do
      user2 =  User.create!(first_name: 'Bill',
                            last_name: 'Seldon',
                            email: 'email3@example.com',
                            street_address: '2954 Virginia Beach Boulevard',
                            city: 'Virginia Beach',
                            state: 'Virginia',
                            zip_code: '23452',
                            password: 'verysecurepassword')
      params2 = {token: ""}

      patch "/api/v1/users", headers: headers, params: JSON.generate(partially_new_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Unauthorized")
    end
  end
end
