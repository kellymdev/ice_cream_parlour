# frozen_string_literal: true

class ProcessDay
  attr_reader :game, :milk_price, :sugar_price, :milk, :sugar, :ice_creams_to_make, :ice_cream_price, :day, :error_list, :ice_creams_sold

  class InvalidInventoryError < StandardError; end

  def initialize(game, day_params)
    @game = game
    @milk_price = day_params[:milk_price].to_d
    @sugar_price = day_params[:sugar_price].to_d
    @milk = day_params[:milk].to_i
    @sugar = day_params[:sugar].to_i
    @ice_creams_to_make = day_params[:ice_creams_to_make].to_i
    @ice_cream_price = day_params[:ice_cream_price].to_d
    @error_list = []
  end

  def call
    build_day

    Day.transaction do
      buy_supplies('milk', milk)
      buy_supplies('sugar', sugar)

      make_ice_cream
    end

    determine_temperature

    sell_ice_creams
    calculate_profit

    day.save

  rescue InvalidInventoryError => e
    @error_list << e.message
    game.reload # reload the game to reset the inventory
  end

  def errors
    error_list
  end

  private

  def build_day
    @day = game.days.build(
      milk_price: milk_price,
      sugar_price: sugar_price
    )
  end

  def cost_of_goods
    cost_of_milk + cost_of_sugar
  end

  def cost_of_milk
    milk * milk_price
  end

  def cost_of_sugar
    sugar * sugar_price
  end

  def buy_supplies(commodity, quantity)
    return if quantity <= 0

    new_balance = game.inventory.balance - send("cost_of_#{commodity}")

    if new_balance <= 0
      raise InvalidInventoryError.new("Insufficient funds to buy #{commodity}")
    else
      game.inventory.update!(
        commodity => game.inventory.send(commodity) + quantity,
        'balance' => new_balance
      )

      day.purchases.build(ingredient: commodity, quantity: quantity)
    end
  end

  def make_ice_cream
    max_ice_creams = [game.inventory.milk, game.inventory.sugar].min

    if max_ice_creams >= ice_creams_to_make
      day.ice_creams_made = ice_creams_to_make
      game.inventory.update!(
        milk: game.inventory.milk - ice_creams_to_make,
        sugar: game.inventory.sugar - ice_creams_to_make
      )
    else
      raise InvalidInventoryError.new("You don't have enough ingredients to make that many ice creams")
    end
  end

  def determine_temperature
    previous_temperature = game.previous_day&.temperature

    day.temperature = CalculateTemperature.new(previous_temperature).call
  end

  def determine_pedestrians
    CalculatePedestrians.new(day.temperature).call
  end

  def ice_creams_sold
    @ice_creams_sold ||= CalculateIceCreamsSold.new(day.ice_creams_made, determine_pedestrians, ice_cream_price).call
  end

  def ice_cream_sales
    ice_cream_price * ice_creams_sold
  end

  def sell_ice_creams
    day.ice_creams_sold = ice_creams_sold
    day.ice_cream_price = ice_cream_price

    game.inventory.update!(balance: game.inventory.balance + ice_cream_sales)
  end

  def calculate_profit
    day.profit = ice_cream_sales - cost_of_goods
  end
end
