require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'validations' do
    let(:day) { create(:day) }
    let(:ingredient) { 'milk' }
    let(:quantity) { 1 }
    let(:purchase) do
      day.purchases.new(
        ingredient: ingredient,
        quantity: quantity
      )
    end

    context 'with valid attributes' do
      it 'is valid' do
        expect(purchase).to be_valid
      end
    end

    describe 'ingredient' do
      context 'without an ingredient' do
        let(:ingredient) {}

        it 'is not valid' do
          expect(purchase).not_to be_valid
          expect(purchase.errors.full_messages.to_sentence).to eq "Ingredient can't be blank"
        end
      end
    end

    describe 'quantity' do
      context 'without a quantity' do
        let(:quantity) {}

        it 'is not valid' do
          expect(purchase).not_to be_valid
          expect(purchase.errors.full_messages.to_sentence).to eq "Quantity can't be blank and Quantity is not a number"
        end
      end

      context 'with an alphabetic character' do
        let(:quantity) { 'a' }

        it 'is not valid' do
          expect(purchase).not_to be_valid
          expect(purchase.errors.full_messages.to_sentence).to eq 'Quantity is not a number'
        end
      end
    end
  end
end
