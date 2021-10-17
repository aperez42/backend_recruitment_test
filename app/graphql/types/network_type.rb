module Types
  class NetworkType < Types::BaseObject
    description "Network"
    field :id, Integer, null: false
    field :name, String, null: false
    field :rides, [Types::RideType], null: true
    field :users, [Types::UserType], null: true
  end
end
