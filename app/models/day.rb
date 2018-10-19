# frozen_string_literal: true

class Day < ApplicationRecord
  belongs_to :game
  has_many :purchases

  validates :temperature, numericality: true, allow_nil: true
  validates :milk_price, numericality: true, allow_nil: true
  validates :sugar_price, numericality: true, allow_nil: true
  validates :ice_creams_made, numericality: true, allow_nil: true
  validates :ice_creams_sold, numericality: true, allow_nil: true
  validates :ice_cream_price, numericality: true, allow_nil: true
  validates :profit, numericality: true, allow_nil: true

  scope :persisted, -> { where.not(id: nil) }
end
