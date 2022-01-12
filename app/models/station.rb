class Station < ApplicationRecord
  validates :api_id, presence: true, uniqueness: true
  
  has_many :user_stations
  has_many :users, through: :user_stations
  
  def self.find_favorite_stations(user)
    Station.joins(:users).where('user_id = ? AND is_favorited = true', user.id)
  end
end
