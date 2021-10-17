require 'rails_helper'

RSpec.describe DriverRide, type: :model do
  let(:network_1) { Network.create(name: 'City1') }
  let(:network_2) { Network.create(name: 'City2') }
  let(:user){ User.create(email: "user@email.com", network: network_1) }
  let(:ride) { Ride.create(departure: "ici", arrival: "la", network: network_1) }
  let(:driver_ride) { DriverRide.new(user: user, ride: ride) }

  describe 'Methods' do
    describe 'same_network' do
      context 'with a ride in the same network' do
        it 'create a passenger ride' do
          expect{ driver_ride.save }.to change { DriverRide.count }.by(1)
        end
      end
      context 'with a ride in another network' do
        before do
          ride.update(network: network_2)
        end
        it 'return false' do
          expect{ driver_ride.save }.to change { DriverRide.count }.by(0)
        end
      end
    end

  end
end
