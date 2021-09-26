require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("email@addresse.foo").for(:email) }
    it { should_not allow_value("emailaddresse.foo").for(:email) }
    it { should_not allow_value("email@addressefoo").for(:email) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:password) }
  end
end
