# frozen_string_literal: true

module PricesHelper
  def format_price(price)
    sprintf("%.2f", price)
  end
end
