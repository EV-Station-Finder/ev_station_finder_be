require 'rails_helper'

RSpec.describe UserStation do
  describe 'relationships' do 
    it { should belong_to :user }
    it { should belong_to :station }
  end
end
