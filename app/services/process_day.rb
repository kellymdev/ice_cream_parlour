# frozen_string_literal: true

class ProcessDay
  attr_reader :game, :milk_price, :sugar_price, :milk, :sugar, :ice_creams_to_make, :ice_cream_price, :day, :error_list

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
    starting_balance = game.inventory.balance

    build_day

    buy_milk
    buy_sugar

    make_ice_cream

    return unless error_list.empty?

    determine_temperature
    pedestrians = determine_pedestrians

    sell_ice_creams(pedestrians)
    calculate_profit(starting_balance)

    day.save
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

  def buy_milk
    cost_of_milk = milk * milk_price
    new_balance = game.inventory.balance - cost_of_milk

    if new_balance <= 0
      error_list << 'Insufficient funds to buy milk'
    else
      game.inventory.update!(milk: game.inventory.milk + milk, balance: new_balance)
      day.purchases.build(ingredient: 'milk', quantity: milk)
    end
  end

  def buy_sugar
    cost_of_sugar = sugar * sugar_price
    new_balance = game.inventory.balance - cost_of_sugar

    if new_balance <= 0
      error_list << 'Insufficient funds to buy sugar'
    else
      game.inventory.update!(sugar: game.inventory.sugar + sugar, balance: new_balance)
      day.purchases.build(ingredient: 'sugar', quantity: sugar)
    end
  end

  def make_ice_cream
    max_ice_creams = [game.inventory.milk, game.inventory.sugar].min

    if max_ice_creams >= ice_creams_to_make
      day.ice_creams_made = ice_creams_to_make
      game.inventory.update!(milk: game.inventory.milk - ice_creams_to_make, sugar: game.inventory.sugar - ice_creams_to_make)
    else
      error_list << "You don't have enough ingredients to make that many ice creams"
    end
  end

  def determine_temperature
    previous_temperature = game.previous_day&.temperature

    day.temperature = CalculateTemperature.new(previous_temperature).call
  end

  def determine_pedestrians
    CalculatePedestrians.new(day.temperature).call
  end

  def sell_ice_creams(pedestrians)
    ice_creams_sold = CalculateIceCreamsSold.new(day.ice_creams_made, pedestrians, ice_cream_price).call
    day.ice_creams_sold = ice_creams_sold
    day.ice_cream_price = ice_cream_price

    sales = ice_cream_price * ice_creams_sold
    game.inventory.update!(balance: game.inventory.balance + sales)
  end

  def calculate_profit(starting_balance)
    day.profit = game.inventory.balance - starting_balance
  end
end
