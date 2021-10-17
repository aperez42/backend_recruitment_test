class PassengerRide < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  belongs_to :driver_ride, optional: true

  validate :same_network

  def same_network
    if user.network != ride.network
      errors.add(:network, 'must be the same for the User and the Ride.')
    elsif driver_ride && driver_ride.ride.network != ride.network
      errors.add(:driver_ride, 'must use the same network than the Ride.')
    end
  end
end
