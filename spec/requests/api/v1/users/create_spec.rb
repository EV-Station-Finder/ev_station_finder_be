require 'rails_helper'

RSpec.describe 'User creation' do
    let(:user_params) { {
                    "first_name": "Hari",
                    "last_name": "Seldon",
                    "email": "hari.seldon@foundation.com",
                    "street_address": "123 Planet XYZ",
                    "city": "Jupiter",
                    "state": "UN",
                    "zip_code": "12345",
                    "password": "verysecurepassword"
                      } }
    let(:headers) { {CONTENT_TYPE: "application/json",
                     ACCEPT: "application/json"} }


  describe 'Happy Path' do
    it 'Creates a new user', :vcr do
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(user_response).to have_key(:data)
      expect(user_response[:data]).to be_a Hash
      expect(user_response[:data]).to have_key(:token)
      expect(user_response[:data]).to have_key(:type)
      expect(user_response[:data][:type]).to eq("user")
    end

    it 'Creates a token for a new user', :vcr do
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user_id = User.last.id
      user_response = JSON.parse(response.body, symbolize_names: true)

      token = user_response[:data][:token]
      decoded_user_id = JWT.decode(token, 'hasselhoff', true, {algorithm: 'HS256'})[0]["user_id"]

      expect(new_user_id).to eq(decoded_user_id)
    end
  end

  describe 'Sad Path' do
    it 'Cannot create new user if email is not provided', :vcr do
      user_params[:"email"] = ""
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Validation failed: Email can't be blank, Email is invalid")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if email is already registered in database', :vcr do
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      user_params2 = {
                      "first_name": "Link",
                      "last_name": "Smith",
                      "email": "hari.seldon@foundation.com",
                      "street_address": "328 Planet Universe",
                      "city": "Earth",
                      "state": "DL",
                      "zip_code": "78968",
                      "password": "anotherverysecurepassword"
                     }
      headers = {CONTENT_TYPE: "application/json",
                 ACCEPT: "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params2)
      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(User.count).to eq(1)
      expect(user_response[:errors]).to eq("Validation failed: Email has already been taken")
    end

    it 'Cannot create new user if password is not provided', :vcr do
      user_params[:"password"] = ""
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Validation failed: Password can't be blank")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if street address is not provided', :vcr do
      user_params[:"street_address"] = ""
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Validation failed: Street address can't be blank")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if city is not provided', :vcr do
      user_params[:"city"] = ""
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Validation failed: City can't be blank")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if state is not provided', :vcr do
      user_params[:"state"] = ""
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Validation failed: State can't be blank")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if zip code is not provided', :vcr do
      user_params[:"zip_code"] = ""
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Validation failed: Zip code can't be blank")
      expect(new_user).to be_nil
    end
  end
end
