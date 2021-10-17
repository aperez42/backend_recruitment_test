class User < ApplicationRecord
  has_many :driver_rides
  has_many :passenger_rides
  belongs_to :network

  validates :email, :network, presence: true
end
