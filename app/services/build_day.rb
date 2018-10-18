# frozen_string_literal: true

class BuildDay
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    prices = calculate_prices

    game.days.build(prices)
  end

  private

  def calculate_prices
    CalculateMarketPrices.new.call
  end
end
