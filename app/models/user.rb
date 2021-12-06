class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :password, presence: true, on: :create

  has_many :user_stations, dependent: :destroy
  has_many :stations, through: :user_stations
end
