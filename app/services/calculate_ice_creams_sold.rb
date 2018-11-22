# frozen_string_literal: true

class CalculateIceCreamsSold
  attr_reader :ice_creams_made, :pedestrian_count, :price

  def initialize(ice_creams_made, pedestrian_count, price)
    @ice_creams_made = ice_creams_made
    @pedestrian_count = pedestrian_count
    @price = price
  end

  def call
    calculate_ice_creams_sold
  end

  private

  def calculate_ice_creams_sold
    sold = (pedestrian_count * price_multiplier).to_i

    if ice_creams_made > sold
      sold
    else
      ice_creams_made
    end
  end

  def price_multiplier
    case price_in_cents
    when 0..50
      0.8
    when 51..100
      0.65
    when 101..150
      0.50
    when 151..200
      0.4
    when 201..500
      0.2
    else
      0.05
    end
  end

  def price_in_cents
    price * 100
  end
end
