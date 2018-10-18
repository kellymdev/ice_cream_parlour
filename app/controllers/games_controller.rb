# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :find_game, only: [:show, :destroy]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = CreateGame.new(game_params).call

    if @game.errors.present?
      render :new
    else
      redirect_to @game
    end
  end

  def show
  end

  def destroy
    @game.destroy

    redirect_to games_path
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
