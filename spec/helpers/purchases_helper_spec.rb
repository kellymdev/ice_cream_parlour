require 'rails_helper'

RSpec.describe PurchasesHelper, type: :helper do
  let(:day) { create(:day) }
  let(:quantity) { 1 }
  let(:ingredient) { 'milk' }
  let(:purchase) { create(:purchase, day: day, ingredient: ingredient, quantity: quantity) }

  describe '#purchase_price' do
    context 'for a milk purchase' do
      let(:ingredient) { 'milk' }

      it 'returns the milk price for the day' do
        expect(helper.purchase_price(ingredient, day)).to eq 0.50
      end
    end

    context 'for a sugar purchase' do
      let(:ingredient) { 'sugar' }

      it 'returns the sugar price for the day' do
        expect(helper.purchase_price(ingredient, day)).to eq 0.02
      end
    end
  end

  describe '#total_purchase_price' do
    context 'with a quantity of 1' do
      let(:quantity) { 1 }

      it 'returns the purchase price' do
        expect(helper.total_purchase_price(purchase, day)).to eq 0.50
      end
    end

    context 'when the quantity is more than 1' do
      let(:quantity) { 2 }

      it 'returns the purchase price multiplied by the quantity' do
        expect(helper.total_purchase_price(purchase, day)).to eq 1.00
      end
    end
  end
end
