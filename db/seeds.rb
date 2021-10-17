# We flush the DB
PassengerRide.delete_all
DriverRide.delete_all
Ride.delete_all
User.delete_all
Network.delete_all

toulouse_network = Network.create!(name: 'Toulouse')
paris_network = Network.create!(name: 'Paris')

# We start by creating some rides,
# These are the available routes our users will be able to use
toulouse_intra = Ride.create!(departure: "Cite de l'espace", arrival: "Capitole", network: toulouse_network)
toulouse_navette = Ride.create!(departure: "Capitole", arrival: "Aeroport", network: toulouse_network)
paris_intra = Ride.create!(departure: "Louvre", arrival: "Nation", network: paris_network)
paris_suburb = Ride.create!(departure: "Clichy", arrival: "Louvre", network: paris_network)

# Now, some users have signed up to our platform
# David, with a "D" as in "Driver"
david = User.create!(email: "david@email.com", network: toulouse_network)

# Patrice, with a "P" as in "Passenger"
patrice = User.create!(email: "patrice@email.com", network: toulouse_network)

# Peter, with a "P" as in "Passenger"
peter = User.create!(email: "peter@email.com", network: toulouse_network)

# Danniel a Driver from Paris
danniel = User.create!(email: 'danniel@email.com', network: paris_network)

# Pascal a Passenger from Paris
pascal = User.create!(email: 'pascal@email.com', network: paris_network)

# Next, our users start to use our transport service
# David inform us that he will drive his car on the toulouse_intra route
david_ride = DriverRide.create!(user: david, ride: toulouse_intra)

# And at the same time, Patrice made a passenger request on the same route
patrice_ride = PassengerRide.create!(user: patrice, ride: toulouse_intra)

# So both of them meet, and David invites Patrice to share the ride
patrice_ride.update(driver_ride: david_ride)

# At the last time, Peter also make a request for the same route
peter_ride = PassengerRide.create!(user: peter, ride: toulouse_intra)

# So David can also take him in his car, he now has two passenger, and his car is almost full.
# So much co2 saved compared to if the three of them had used their own car
peter_ride.update(driver_ride: david_ride)

# Paris exemple :
danniel_ride = DriverRide.create!(user: danniel, ride: paris_intra)
pascal_ride = PassengerRide.create!(user: pascal, ride: paris_intra)
pascal_ride.update(driver_ride: danniel_ride)
