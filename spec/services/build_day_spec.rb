require 'rails_helper'

RSpec.describe BuildDay, type: :service do
  describe '#call' do
    let(:game) { create(:game) }
    subject(:service) { described_class.new(game) }

    it 'sets a milk_price and a sugar_price for the day' do
      day = service.call

      expect(day.milk_price).not_to be_nil
      expect(day.sugar_price).not_to be_nil
    end
  end
end
