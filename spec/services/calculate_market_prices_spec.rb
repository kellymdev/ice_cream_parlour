require 'rails_helper'

RSpec.describe CalculateMarketPrices, type: :service do
  describe '#call' do
    subject(:prices) { described_class.new.call }

    it 'returns a value between 0.25 and 0.50 for the milk price' do
      expect(prices[:milk_price]).to be_between(0.25, 0.50)
    end

    it 'returns a value between 0.02 and 0.05 for the sugar price' do
      expect(prices[:sugar_price]).to be_between(0.02, 0.05)
    end
  end
end
