require 'rails_helper'

RSpec.describe Game, type: :model do
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
end
