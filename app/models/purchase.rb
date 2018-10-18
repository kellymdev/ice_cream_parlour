class Purchase < ApplicationRecord
  belongs_to :day

  validates :ingredient, presence: true
  validates :quantity, presence: true, numericality: true

  enum ingredient: { milk: 'milk', sugar: 'sugar' }
end
