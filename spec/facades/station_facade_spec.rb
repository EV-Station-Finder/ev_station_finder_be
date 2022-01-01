require 'rails_helper'

RSpec.describe StationFacade do
  let!(:user1) { User.create(first_name: 'Bill',
                              last_name: 'Seldon',
                              email: 'email@example.com',
                              street_address: '2954 Virginia Beach Boulevard',
                              city: 'Virginia Beach',
                              state: 'Virginia',
                              zip_code: '23452',
                              password: 'verysecurepassword') }
  let(:location) {"Denver, CO"}
  let(:id) {152087}
                              
  describe "::get_stations" do
    describe "provided with location but without user_id input" do
      it "should return an array of station objects", :vcr do
        result = StationFacade.get_stations(location)

        expect(result).to be_a(Array)
        expect(result[0]).to be_a StationBasic
      end
    end
    
    describe "provided with location and user_id inputs" do
      it "should return an array of station objects", :vcr do
        result = StationFacade.get_stations(location, user1.id)
        
        expect(result).to be_a(Array)
        expect(result[0]).to be_a StationBasic
      end
    end
  end

  describe "::get_station" do
    describe "provided with station api_id but without user_id input" do
      it "should return an array of station objects", :vcr do
        result = StationFacade.get_station(id)

        expect(result).to be_a StationDetails
      end
    end
    
    describe "provided with station api_id but without user_id input" do
      it "should return an array of station objects", :vcr do
        result = StationFacade.get_station(id, user1.id)

        expect(result).to be_a StationDetails
      end
    end
  end
end
