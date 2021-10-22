require 'rails_helper'

RSpec.describe Station do
  describe 'validations' do
    it { should validate_presence_of(:api_id) }
    it { should validate_uniqueness_of(:api_id) }
  end

  describe 'relationships' do
    it { should have_many :user_stations }
    it { should have_many(:users).through(:user_stations) }
  end 
end
