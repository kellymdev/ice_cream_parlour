# frozen_string_literal: true

class CalculateTemperature
  attr_reader :previous_temperature

  TEMPERATURE_RANGE = 10..25

  def initialize(previous_temperature = nil)
    @previous_temperature = previous_temperature
  end

  def call
    calculate_temperature
  end

  private

  def calculate_temperature
    temperature = random_temperature

    unless previous_temperature.nil?
      temperature = (random_temperature + previous_temperature) / 2
    end

    temperature
  end

  def random_temperature
    rand(TEMPERATURE_RANGE)
  end
end
