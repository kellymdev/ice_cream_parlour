require 'rails_helper'

RSpec.describe CreateGame, type: :service do
  describe '#call' do
    let(:service) { described_class.new(game_params) }

    context 'with valid params' do
      let(:game_params) do
        {
          name: 'Delicious Ice Creams'
        }
      end

      it 'creates a game and an inventory' do
        expect { service.call }.to change { Game.count }.by(1).and change { Inventory.count }.by(1)
      end

      it 'creates an inventory with a balance of $5.00' do
        game = service.call

        expect(game.inventory.balance).to eq 5.0
      end
    end

    context 'with invalid params' do
      let(:game_params) do
        {
          name: 'A'
        }
      end

      it 'does not save the game' do
        expect { service.call }.not_to change { Game.count }
      end

      it 'does not create an inventory' do
        expect { service.call }.not_to change { Inventory.count }
      end

      it 'returns the game with its errors' do
        game = service.call

        expect(game.errors.full_messages.to_sentence).to eq 'Name is too short (minimum is 2 characters)'
      end
    end
  end
end
