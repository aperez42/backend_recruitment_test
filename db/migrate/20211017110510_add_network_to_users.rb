class AddNetworkToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :network, foreign_key: true
  end
end
