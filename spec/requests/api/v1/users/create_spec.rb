require 'rails_helper'

RSpec.describe 'User creation' do
  before do
    @user_params = {
                    "first_name": "Hari",
                    "last_name": "Seldon",
                    "email": "hari.seldon@foundation.com",
                    "street_address": "123 Planet XYZ",
                    "city": "Jupiter",
                    "state": "UN",
                    "zip_code": "12345",
                    "password": "verysecurepassword"
                   }
    @headers = {CONTENT_TYPE: "application/json",
               ACCEPT: "application/json"}
  end

  describe 'Happy Path' do
    it 'Creates a new user' do
      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(user_response).to have_key(:data)
      expect(user_response[:data]).to be_a Hash
      expect(user_response[:data]).to have_key(:type)
      expect(user_response[:data]).to have_key(:id)
      expect(user_response[:data]).to have_key(:attributes)
      expect(user_response[:data][:id]).to eq(new_user.id.to_s)
      expect(user_response[:data][:type]).to eq("user")
      expect(user_response[:data][:attributes].size).to eq(7)
      expect(user_response[:data][:attributes][:first_name]).to eq("Hari")
      expect(user_response[:data][:attributes][:last_name]).to eq("Seldon")
      expect(user_response[:data][:attributes][:email]).to eq("hari.seldon@foundation.com")
      expect(user_response[:data][:attributes][:street_address]).to eq("123 Planet XYZ")
      expect(user_response[:data][:attributes][:city]).to eq("Jupiter")
      expect(user_response[:data][:attributes][:state]).to eq("UN")
      expect(user_response[:data][:attributes][:zip_code]).to eq("12345")
    end
  end

  describe 'Sad Path' do
    it 'Cannot create new user if email is not provided' do
      @user_params[:"email"] = ""
      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Validation failed: Email can't be blank")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if email is already registered in database' do

      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params)
      @user_params2 = {
                      "first_name": "Link",
                      "last_name": "Smith",
                      "email": "hari.seldon@foundation.com",
                      "street_address": "328 Planet Universe",
                      "city": "Earth",
                      "state": "DL",
                      "zip_code": "78968",
                      "password": "anotherverysecurepassword"
                     }
      @headers = {CONTENT_TYPE: "application/json",
                 ACCEPT: "application/json"}

      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params2)
      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(User.count).to eq(1)
      expect(user_response[:errors]).to eq("Validation failed: Email has already been taken")
    end

    it 'Cannot create new user if password is not provided' do
      @user_params[:"password"] = ""
      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Bad request: missing information")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if street address is not provided' do
      @user_params[:"street_address"] = ""
      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Bad request: missing information")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if city is not provided' do
      @user_params[:"city"] = ""
      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Bad request: missing information")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if state is not provided' do
      @user_params[:"state"] = ""
      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Bad request: missing information")
      expect(new_user).to be_nil
    end

    it 'Cannot create new user if zip code is not provided' do
      @user_params[:"zip_code"] = ""
      post "/api/v1/users", headers: @headers, params: JSON.generate(@user_params)

      new_user = User.last
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(user_response[:errors]).to eq("Bad request: missing information")
      expect(new_user).to be_nil
    end
  end
end
