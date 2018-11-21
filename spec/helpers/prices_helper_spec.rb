require 'rails_helper'

RSpec.describe PricesHelper, :type => :helper do
  describe '#format_price' do
    it 'formats the price to two decimal places' do
      expect(helper.format_price(0.1)).to eq '0.10'
    end
  end

  describe '#profit_description' do
    context 'when the amount is positive' do
      it "returns 'profit'" do
        expect(helper.profit_description(0.01)).to eq 'profit'
      end
    end

    context 'when the amount is zero' do
      it "returns 'profit'" do
        expect(helper.profit_description(0.0)).to eq 'profit'
      end
    end

    context 'when the amount is negative' do
      it "returns 'loss'" do
        expect(helper.profit_description(-0.01)).to eq 'loss'
      end
    end
  end
end
