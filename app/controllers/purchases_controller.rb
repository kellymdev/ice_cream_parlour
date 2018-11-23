# frozen_string_literal: true

class PurchasesController < ApplicationController
  def index
    @day = Day.find(params[:day_id])
    @purchases = @day.purchases
  end
end
