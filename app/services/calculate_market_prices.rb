# frozen_string_literal: true

class CalculateMarketPrices
  MILK_PRICE_RANGE = 25..50
  SUGAR_PRICE_RANGE = 2..5

  def call
    {
      milk_price: calculate_price_in_dollars(MILK_PRICE_RANGE),
      sugar_price: calculate_price_in_dollars(SUGAR_PRICE_RANGE)
    }
  end

  private

  def calculate_price_in_dollars(price_range)
    rand(price_range) / 100.0
  end
end
