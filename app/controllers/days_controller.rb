# frozen_string_literal: true

class DaysController < ApplicationController
  before_action :find_game

  def new
    @day = BuildDay.new(@game).call
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end
end
