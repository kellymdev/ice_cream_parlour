class Game < ApplicationRecord
  has_one :inventory, dependent: :destroy, inverse_of: :game

  validates :name, presence: true, length: { minimum: 2 }
end
