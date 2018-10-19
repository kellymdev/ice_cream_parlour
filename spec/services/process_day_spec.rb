require 'rails_helper'

RSpec.describe ProcessDay, type: :service do
  describe '#call' do
    let!(:game) { create(:game) }
    let!(:inventory) { create(:inventory, game: game) }
    let(:balance) { 5.00 }
    let(:ice_creams_to_make) { 1 }
    let(:day_params) do
      {
        milk_price: 0.50,
        sugar_price: 0.02,
        milk: 1,
        sugar: 1,
        ice_creams_to_make: ice_creams_to_make,
        ice_cream_price: 0.60
      }
    end

    before do
      game.inventory.update!(balance: balance)
    end

    subject(:service) { described_class.new(game, day_params) }

    context 'with sufficient funds' do
      it 'creates a day' do
        expect { service.call }.to change { Day.count }.by 1
      end

      it 'sets the values for the day' do
        service.call
        day = Day.last

        expect(day.milk_price).to eq 0.50
        expect(day.sugar_price).to eq 0.02
        expect(day.ice_creams_made).to eq 1
        expect(day.ice_cream_price).to eq 0.60

        expect(day.temperature).not_to be_nil
        expect(day.profit).not_to be_nil
        expect(day.ice_creams_sold).not_to be_nil
      end
    end

    context 'when there are insufficient funds to buy milk' do
      let(:balance) { 0.01 }

      it 'does not create a day' do
        expect { service.call }.not_to change { Day.count }
      end

      it 'creates an error on the service' do
        service.call

        expect(service.errors).to include 'Insufficient funds to buy milk'
      end
    end

    context 'when there are insufficient funds to buy sugar' do
      let(:balance) { 0.51 }

      it 'does not create a day' do
        expect { service.call }.not_to change { Day.count }
      end

      it 'creates an error on the service' do
        service.call

        expect(service.errors).to include 'Insufficient funds to buy sugar'
      end
    end

    context 'when there are not enough ingredients to make the requested ice creams' do
      let(:ice_creams_to_make) { 5 }

      it 'does not create a day' do
        expect { service.call }.not_to change { Day.count }
      end

      it 'creates an error on the service' do
        service.call

        expect(service.errors).to include "You don't have enough ingredients to make that many ice creams"
      end
    end
  end
end
