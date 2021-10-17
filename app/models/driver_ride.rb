class DriverRide < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  has_many :passenger_rides

  validate :same_network

  def same_network
    if user.network != ride.network
      errors.add(:network, 'must be the same for the User and the Ride.')
    elsif passenger_rides.any? && !passenger_rides.pluck(:network).uniq.include?(ride.network)
      errors.add(:passenger_rides, 'must use the same network than the Ride.')
    end
  end
end
