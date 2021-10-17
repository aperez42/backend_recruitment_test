module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false, description: "An user" do
      argument :network_id, Integer, required: true
    end
    def users(network_id:)
      user = User.where(network_id: network_id)
      puts user.inspect
      user
    end
  end
end
