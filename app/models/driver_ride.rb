class DriverRide < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  has_many :passenger_rides

  validate :same_network

  def same_network
    ride_ids = passenger_rides.pluck(:ride_id).uniq
    passenger_ride_networks = Ride.find(ride_ids).pluck(:network_id).uniq

    if user.network != ride.network
      errors.add(:network, 'must be the same for the User and the Ride.')
    elsif passenger_rides.any? && !passenger_ride_networks.include?(ride.network)
      errors.add(:passenger_rides, 'must use the same network than the Ride.')
    end
  end
end
