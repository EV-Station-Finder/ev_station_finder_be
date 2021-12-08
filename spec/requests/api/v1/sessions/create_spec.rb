require 'rails_helper'

RSpec.describe 'User session' do
    let(:registration_params) { {
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
                  
    let(:new_user) { User.last }

    let(:login_params) { {
                      email: "hari.seldon@foundation.com",
                      password: "verysecurepassword"
                        } }
    before do
      post "/api/v1/users", headers: headers, params: JSON.generate(registration_params)
    end

  describe 'Happy Path' do
    it 'Logs in a user', :vcr do
      post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(session_response).to have_key(:data)
      expect(session_response[:data]).to be_a Hash
      expect(session_response[:data]).to have_key(:token)
      expect(session_response[:data]).to have_key(:type)
      expect(session_response[:data][:type]).to eq("user")
    end
  end

  describe 'Sad Path' do
    it 'Cannot login user if user is not already registered in database', :vcr do
      login_params[:"email"] = "mouse@gmail.net"

      post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end

    it 'Cannot login user if email is invalid', :vcr do
      login_params[:"email"] = "thisisaninvalidemail"
      post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end

    it 'Cannot login user if email is not provided', :vcr do
      login_params[:"email"] = ""

      post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end

    it 'Cannot login user with invalid password', :vcr do
      login_params[:"password"] = "mouse4lyfe"
      post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end

    it 'Cannot login user if password is not provided', :vcr do
      login_params[:"password"] = ""
      post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)

      session_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(session_response[:errors]).to eq("Invalid parameters")
    end
  end
end
