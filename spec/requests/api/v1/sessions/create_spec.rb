require 'rails_helper'

RSpec.describe 'User session' do
  before do
    @registration_params = {
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

    post "/api/v1/users", headers: @headers, params: JSON.generate(@registration_params)

    @new_user = User.last

    @login_params = {
                      email: "hari.seldon@foundation.com",
                      password: "verysecurepassword"
                    }
  end

  describe 'Happy Path' do
    it 'Logs in a user' do
      post "/api/v1/sessions", headers: @headers, params: JSON.generate(@login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(session_response).to have_key(:data)
      expect(session_response[:data]).to be_a Hash
      expect(session_response[:data]).to have_key(:type)
      expect(session_response[:data]).to have_key(:id)
      expect(session_response[:data]).to have_key(:attributes)
      expect(session_response[:data][:id]).to eq(@new_user.id.to_s)
      expect(session_response[:data][:type]).to eq("user")
      expect(session_response[:data][:attributes].size).to eq(7)
      expect(session_response[:data][:attributes][:first_name]).to eq("Hari")
      expect(session_response[:data][:attributes][:last_name]).to eq("Seldon")
      expect(session_response[:data][:attributes][:email]).to eq("hari.seldon@foundation.com")
      expect(session_response[:data][:attributes][:street_address]).to eq("123 Planet XYZ")
      expect(session_response[:data][:attributes][:city]).to eq("Jupiter")
      expect(session_response[:data][:attributes][:state]).to eq("UN")
      expect(session_response[:data][:attributes][:zip_code]).to eq("12345")
    end
  end

  describe 'Sad Path' do
    it 'Cannot login user if user is not already registered in database' do
      @login_params[:"email"] = "mouse@gmail.net"

      post "/api/v1/sessions", headers: @headers, params: JSON.generate(@login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end

    it 'Cannot login user if email is invalid' do
      @login_params[:"email"] = "thisisaninvalidemail"
      post "/api/v1/sessions", headers: @headers, params: JSON.generate(@login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end

    it 'Cannot login user if email is not provided' do
      @login_params[:"email"] = ""

      post "/api/v1/sessions", headers: @headers, params: JSON.generate(@login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end

    it 'Cannot login user with invalid password' do
      @login_params[:"password"] = "mouse4lyfe"
      post "/api/v1/sessions", headers: @headers, params: JSON.generate(@login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end

    it 'Cannot login user if password is not provided' do
      @login_params[:"password"] = ""
      post "/api/v1/sessions", headers: @headers, params: JSON.generate(@login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end
  end
end
