require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { create(:game) }

  describe 'validations' do
    describe 'name' do
      let(:game) { Game.new(name: name) }

      context 'with a valid name' do
        let(:name) { 'Test' }

        it 'is valid' do
          expect(game).to be_valid
        end
      end

      context 'without a name' do
        let(:name) { '' }

        it 'is invalid' do
          expect(game).not_to be_valid
          expect(game.errors.full_messages.to_sentence).to eq "Name can't be blank and Name is too short (minimum is 2 characters)"
        end
      end

      context 'with a name that is too short' do
        let(:name) { 'T' }

        it 'is invalid' do
          expect(game).not_to be_valid
          expect(game.errors.full_messages.to_sentence).to eq 'Name is too short (minimum is 2 characters)'
        end
      end
    end
  end

  describe '#previous_day' do
    context 'when there is a previous day' do
      let!(:day_1) { create(:day, game: game) }
      let!(:day_2) { create(:day, game: game) }

      it 'returns the last saved day for the game' do
        expect(game.previous_day).to eq day_2
      end
    end

    context 'when there are no days for the game' do
      it 'returns nil' do
        expect(game.previous_day).to eq nil
      end
    end
  end

  describe '#total_profit' do
    let!(:inventory) { create(:inventory, game: game, balance: balance) }

    context 'when the inventory balance is higher than the starting balance' do
      let(:balance) { 5.01 }

      it 'returns a positive profit' do
        expect(game.total_profit).to eq 0.01
      end
    end

    context 'when the inventory balance is the same as the starting balance' do
      let(:balance) { 5.0 }

      it 'returns zero' do
        expect(game.total_profit).to eq 0
      end
    end

    context 'when the inventory balance is lower than the starting balance' do
      let(:balance) { 4.99 }

      it 'returns a loss' do
        expect(game.total_profit).to eq(-0.01)
      end
    end
  end
end
