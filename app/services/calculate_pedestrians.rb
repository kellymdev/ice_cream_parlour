# frozen_string_literal: true

class CalculatePedestrians
  attr_reader :temperature

  def initialize(temperature)
    @temperature = temperature
  end

  def call
    pedestrian_count(pedestrian_range)
  end

  private

  def pedestrian_range
    case temperature
    when 10..15
      5..15
    when 16..20
      16..40
    when 21..25
      41..60
    end
  end

  def pedestrian_count(count_range)
    rand(count_range)
  end
end
