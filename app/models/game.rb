class Game < ApplicationRecord
  has_one :inventory, dependent: :destroy, inverse_of: :game
  has_many :days, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }
end
