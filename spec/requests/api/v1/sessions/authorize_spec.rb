require 'rails_helper'

RSpec.describe 'User authorization' do
  before do
    registration_params = {
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

    post "/api/v1/users", headers: @headers, params: JSON.generate(registration_params)

    login_params = {
                      email: "hari.seldon@foundation.com",
                      password: "verysecurepassword"
                    }
    post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)

    session_response = JSON.parse(response.body, symbolize_names: true)
    @token = session_response[:data][:token]
  end

  describe 'Happy Path' do
    it 'Authorizes a user' do
      token_params = {"token": @token}
      get api_v1_authorize_path, headers: @headers, params: token_params
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
    it 'Does not authorize user because token is incorrect' do
      token_params = {"token": "wrJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNDV9.l_pdekbafUTPaz88h1qXUIw_Bg7PJPa_4Eu81AN7yfA"}
      get api_v1_authorize_path, headers: @headers, params: token_params
      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(session_response[:errors]).to eq("Not logged in")
    end
    
    it 'Does not authorize user because token is empty string' do
      token_params = {"token": ""}
      get api_v1_authorize_path, headers: @headers, params: token_params
      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(session_response[:errors]).to eq("Not logged in")
    end
    
    it 'Does not authorize user because token is not provided' do
      get api_v1_authorize_path
      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(session_response[:errors]).to eq("Not logged in")
    end
  end
end