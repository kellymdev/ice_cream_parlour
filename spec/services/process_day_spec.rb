require 'rails_helper'

RSpec.describe ProcessDay, type: :service do
  describe '#call' do
    let!(:game) { create(:game) }
    let!(:inventory) { create(:inventory, game: game, balance: balance) }
    let(:balance) { 5.00 }
    let(:milk) { 1 }
    let(:sugar) { 1 }
    let(:ice_creams_to_make) { 1 }
    let(:day_params) do
      {
        milk_price: 0.50,
        sugar_price: 0.02,
        milk: milk,
        sugar: sugar,
        ice_creams_to_make: ice_creams_to_make,
        ice_cream_price: 0.60
      }
    end

    subject(:service) { described_class.new(game, day_params) }

    context 'with sufficient funds' do
      before do
        allow_any_instance_of(CalculateIceCreamsSold).to receive(:call).and_return(1)
      end

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
        expect(day.profit).to eq 0.08
        expect(day.ice_creams_sold).to eq 1
      end

      it 'creates a purchase for each ingredient' do
        expect { service.call }.to change { Purchase.count }.by 2
      end
    end

    context 'invalid purchase quantity' do
      let(:ice_creams_to_make) { 0 }

      context 'when the purchase quantity is 0' do
        let(:milk) { 0 }
        let(:sugar) { 0 }

        it 'does not create a purchase' do
          expect { service.call }.not_to change { Purchase.count }
        end
      end

      context 'when the purchase quantity is less than 0' do
        let(:milk) { -1 }
        let(:sugar) { -1 }

        it 'does not create a purchase' do
          expect { service.call }.not_to change { Purchase.count }
        end
      end
    end

    context 'insufficient funds' do
      let(:ice_creams_to_make) { 2 }

      context 'when there are insufficient funds to buy milk' do
        let(:balance) { 0.01 }

        it 'does not create a day' do
          expect { service.call }.not_to change { Day.count }
        end

        it 'creates an error on the service' do
          service.call

          expect(service.errors).to include 'Insufficient funds to buy milk'
        end

        it 'does not change the inventory' do
          expect(game.inventory.milk).to eq 1
          expect(game.inventory.sugar).to eq 1
          expect(game.inventory.balance).to eq balance
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

        it 'does not change the inventory' do
          expect(game.inventory.milk).to eq 1
          expect(game.inventory.sugar).to eq 1
          expect(game.inventory.balance).to eq balance
        end
      end
    end

    context 'when there are not enough ingredients to make the requested ice creams' do
      let(:ice_creams_to_make) { 5 }

      before do
        game.inventory.update!(
          milk: 3,
          sugar: 3
        )
      end

      it 'does not create a day' do
        expect { service.call }.not_to change { Day.count }
      end

      it 'creates an error on the service' do
        service.call

        expect(service.errors).to include "You don't have enough ingredients to make that many ice creams"
      end

      it 'does not change the inventory' do
        expect(game.inventory.milk).to eq 3
        expect(game.inventory.sugar).to eq 3
        expect(game.inventory.balance).to eq balance
      end
    end
  end
end
