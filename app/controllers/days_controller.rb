# frozen_string_literal: true

class DaysController < ApplicationController
  before_action :find_game

  def new
    @day = BuildDay.new(@game).call
  end

  def create
    service = ProcessDay.new(@game, day_params)
    service.call

    if service.errors.any?
      @errors = service.errors

      @day = @game.days.new(milk_price: day_params[:milk_price], sugar_price: day_params[:sugar_price])
      render :new
    else
      redirect_to @game
    end
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def day_params
    params.require(:day).permit(:milk_price, :sugar_price, :milk, :sugar, :ice_creams_to_make, :ice_cream_price)
  end
end
