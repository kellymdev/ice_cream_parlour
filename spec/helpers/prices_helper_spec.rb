require 'rails_helper'

RSpec.describe PricesHelper, :type => :helper do
  describe '#format_price' do
    it 'formats the price to two decimal places' do
      expect(helper.format_price(0.1)).to eq '0.10'
    end
  end
end
