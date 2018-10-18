# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :find_game, only: [:show]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end
end
