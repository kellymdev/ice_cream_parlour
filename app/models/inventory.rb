class Inventory < ApplicationRecord
  belongs_to :game, inverse_of: :inventory

  validates :milk, presence: true, numericality: true
  validates :sugar, presence: true, numericality: true
  validates :ice_creams, presence: true, numericality: true
  validates :balance, presence: true, numericality: true
end
