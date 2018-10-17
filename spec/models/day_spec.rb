require 'rails_helper'

RSpec.describe Day, type: :model do
  fixtures :games

  describe 'validations' do
    let(:game) { games(:game_one) }
    let(:temperature) { 20.0 }
    let(:milk_price) { 0.5 }
    let(:sugar_price) { 0.02 }
    let(:ice_creams_made) { 0 }
    let(:ice_creams_sold) { 0 }
    let(:ice_cream_price) { 1.0 }
    let(:profit) { 0.0 }
    let(:day) do
      game.days.new(
        temperature: temperature,
        milk_price: milk_price,
        sugar_price: sugar_price,
        ice_creams_made: ice_creams_made,
        ice_creams_sold: ice_creams_sold,
        ice_cream_price: ice_cream_price,
        profit: profit
      )
    end

    context 'with valid attributes' do
      it 'is valid' do
        expect(day).to be_valid
      end
    end

    describe 'temperature' do
      context 'with an alphabetic character' do
        let(:temperature) { 'a' }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Temperature is not a number'
        end
      end
    end

    describe 'milk_price' do
      context 'with an alphabetic character' do
        let(:milk_price) { 'a' }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Milk price is not a number'
        end
      end
    end

    describe 'sugar_price' do
      context 'with an alphabetic character' do
        let(:sugar_price) { 'a' }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Sugar price is not a number'
        end
      end
    end

    describe 'ice_creams_made' do
      context 'with an alphabetic character' do
        let(:ice_creams_made) { 'a' }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Ice creams made is not a number'
        end
      end
    end

    describe 'ice_creams_sold' do
      context 'with an alphabetic character' do
        let(:ice_creams_sold) { 'a' }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Ice creams sold is not a number'
        end
      end
    end

    describe 'ice_cream_price' do
      context 'with an alphabetic character' do
        let(:ice_cream_price) { 'a' }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Ice cream price is not a number'
        end
      end
    end

    describe 'profit' do
      context 'with an alphabetic character' do
        let(:profit) { 'a' }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Profit is not a number'
        end
      end
    end
  end
end
