# frozen_string_literal: true

class CreateGame
  STARTING_BALANCE = 5.0

  attr_reader :game_params, :game

  def initialize(game_params)
    @game_params = game_params
  end

  def call
    @game = Game.new(game_params)

    create_inventory if game.save

    game
  end

  private

  def create_inventory
    game.create_inventory(balance: STARTING_BALANCE)
  end
end
