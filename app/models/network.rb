class Network < ApplicationRecord
  has_many :rides
  has_many :users

  validates :name, presence: true
end
