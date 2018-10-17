require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'validations' do
    let(:game) do
      Game.create!(name: 'Test')
    end
    let(:milk) { 0 }
    let(:sugar) { 0 }
    let(:ice_creams) { 0 }
    let(:balance) { 0.0 }
    let(:inventory) do
      game.create_inventory(
        milk: milk,
        sugar: sugar,
        ice_creams: ice_creams,
        balance: balance
      )
    end

    context 'with valid attributes' do
      it 'is valid' do
        expect(inventory).to be_valid
      end
    end

    describe 'milk' do
      context 'without a value' do
        let(:milk) {}

        it 'is not valid' do
          expect(inventory).not_to be_valid
          expect(inventory.errors.full_messages.to_sentence).to eq "Milk can't be blank and Milk is not a number"
        end
      end

      context 'with an alphabetic character' do
        let(:milk) { 'a' }

        it 'is not valid' do
          expect(inventory).not_to be_valid
          expect(inventory.errors.full_messages.to_sentence).to eq 'Milk is not a number'
        end
      end
    end

    describe 'sugar' do
      context 'without a value' do
        let(:sugar) {}

        it 'is not valid' do
          expect(inventory).not_to be_valid
          expect(inventory.errors.full_messages.to_sentence).to eq "Sugar can't be blank and Sugar is not a number"
        end
      end

      context 'with an alphabetic character' do
        let(:sugar) { 'a' }

        it 'is not valid' do
          expect(inventory).not_to be_valid
          expect(inventory.errors.full_messages.to_sentence).to eq 'Sugar is not a number'
        end
      end
    end

    describe 'ice_creams' do
      context 'without a value' do
        let(:ice_creams) {}

        it 'is not valid' do
          expect(inventory).not_to be_valid
          expect(inventory.errors.full_messages.to_sentence).to eq "Ice creams can't be blank and Ice creams is not a number"
        end
      end

      context 'with an alphabetic character' do
        let(:ice_creams) { 'a' }

        it 'is not valid' do
          expect(inventory).not_to be_valid
          expect(inventory.errors.full_messages.to_sentence).to eq 'Ice creams is not a number'
        end
      end
    end

    describe 'balance' do
      context 'without a value' do
        let(:balance) {}

        it 'is not valid' do
          expect(inventory).not_to be_valid
          expect(inventory.errors.full_messages.to_sentence).to eq "Balance can't be blank and Balance is not a number"
        end
      end

      context 'with an alphabetic character' do
        let(:balance) { 'a' }

        it 'is not valid' do
          expect(inventory).not_to be_valid
          expect(inventory.errors.full_messages.to_sentence).to eq 'Balance is not a number'
        end
      end
    end
  end
end
