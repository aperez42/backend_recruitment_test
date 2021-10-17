require "rails_helper"

RSpec.describe "Ride sharing between a driver and a passenger", :type => :request do

  let(:network_1) { Network.create(name: 'City1') }
  let(:network_2) { Network.create(name: 'City2') }
  let(:driver){ User.create(email: "david@email.com", network: network_1) }
  let(:passenger) { User.create(email: "peter@email.com", network: network_1) }
  let(:ride) { Ride.create(departure: "ici", arrival: "la", network: network_1) }
  let(:ride_2) { Ride.create(departure: "ici", arrival: "la", network: network_2) }

  it "creates a Widget and redirects to the Widget's page" do
    post "/graphql", params: {
      query: "mutation{
        createDriverRide(
          input: {
          	userId: #{driver.id},
          	rideId: #{ride.id}
        	}
        ){
          driverRide{
            id
          }
          errors
        }
      }"
    }

    expect(DriverRide.last.user).to eq(driver)
    expect(DriverRide.last.ride).to eq(ride)

    post "/graphql", params: {
      query: "mutation{
        createPassengerRide(
          input: {
          	userId: #{passenger.id},
          	rideId: #{ride.id}
        	}
        ){
          passengerRide{
            id
          }
          errors
        }
      }"
    }

    expect(PassengerRide.last.user).to eq(passenger)
    expect(PassengerRide.last.ride).to eq(ride)

    post "/graphql", params: {
      query: "mutation{
        shareRide(
          input: {
          	driverRideId: #{DriverRide.last.id},
          	passengerRideId: #{PassengerRide.last.id}
        	}
        ){
          passengerRide{
            id
          }
          errors
        }
      }"
    }

    p response.body
    expect(PassengerRide.last.driver_ride).to eq(DriverRide.last)
  end

    it "failed to create a Widget" do
    post "/graphql", params: {
      query: "mutation{
        createDriverRide(
          input: {
          	userId: #{driver.id},
          	rideId: #{ride_2.id}
        	}
        ){
          driverRide{
            id
          }
          errors
        }
      }"
    }

    expect(DriverRide.last).to be_nil

    post "/graphql", params: {
      query: "mutation{
        createPassengerRide(
          input: {
          	userId: #{passenger.id},
          	rideId: #{ride_2.id}
        	}
        ){
          passengerRide{
            id
          }
          errors
        }
      }"
    }

    expect(PassengerRide.last).to be_nil
  end
end
