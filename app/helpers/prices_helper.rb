# frozen_string_literal: true

module PricesHelper
  def format_price(price)
    sprintf("%.2f", price)
  end

  def profit_description(amount)
    if amount.positive? || amount.zero?
      'profit'
    else
      'loss'
    end
  end
end
