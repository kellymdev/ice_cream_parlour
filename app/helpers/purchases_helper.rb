# frozen_string_literal: true

module PurchasesHelper
  def purchase_price(ingredient, day)
    day.send("#{ingredient}_price")
  end

  def total_purchase_price(purchase, day)
    unit_price = purchase_price(purchase.ingredient, day)
    unit_price * purchase.quantity
  end
end
