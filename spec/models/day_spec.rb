require 'rails_helper'

RSpec.describe Day, type: :model do
  let(:game) { create(:game) }

  describe 'validations' do
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
          expect(day.errors.full_messages.to_sentence).to eq 'Milk price is not a number and Milk price is not included in the list'
        end
      end

      context 'with a price that is too low' do
        let(:milk_price) { 0.20 }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Milk price is not included in the list'
        end
      end

      context 'with a price that is too high' do
        let(:milk_price) { 0.51 }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Milk price is not included in the list'
        end
      end
    end

    describe 'sugar_price' do
      context 'with an alphabetic character' do
        let(:sugar_price) { 'a' }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Sugar price is not a number and Sugar price is not included in the list'
        end
      end

      context 'with a price that is too low' do
        let(:sugar_price) { 0.01 }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Sugar price is not included in the list'
        end
      end

      context 'with a price that is too high' do
        let(:sugar_price) { 0.06 }

        it 'is not valid' do
          expect(day).not_to be_valid
          expect(day.errors.full_messages.to_sentence).to eq 'Sugar price is not included in the list'
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

  describe 'scopes' do
    describe 'persisted' do
      let(:day_1) { game.days.create! }
      let(:day_2) { game.days.build }

      it 'returns days that have been saved to the database' do
        expect(game.days.persisted).to include day_1
      end

      it 'does not return days that are new records' do
        expect(game.days.persisted).not_to include day_2
      end
    end
  end
end
