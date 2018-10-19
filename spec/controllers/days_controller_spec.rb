require 'rails_helper'

RSpec.describe DaysController, type: :controller do
  render_views

  let!(:game) { create(:game) }
  let!(:inventory) { create(:inventory, game: game) }

  describe '#new' do
    it 'calls the BuildDay service' do
      expect(BuildDay).to receive(:new).with(game).and_call_original

      get :new, params: { game_id: game.to_param }
    end

    it 'renders the new template' do
      get :new, params: { game_id: game.to_param }

      expect(response).to render_template :new
    end
  end

  describe '#create' do
    let(:milk_price) { '0.50' }
    let(:sugar_price) { '0.02' }
    let(:milk) { '1' }
    let(:sugar) { '1' }
    let(:ice_creams_to_make) { '1' }
    let(:ice_cream_price) { '0.60' }

    let(:strong_params) do
      ActionController::Parameters.new(milk_price: milk_price, sugar_price: sugar_price, milk: milk, sugar: sugar, ice_creams_to_make: ice_creams_to_make, ice_cream_price: ice_cream_price).permit!
    end
    let(:day_params) do
      {
        game_id: game.to_param,
        day: {
          milk_price: milk_price,
          sugar_price: sugar_price,
          milk: milk,
          sugar: sugar,
          ice_creams_to_make: ice_creams_to_make,
          ice_cream_price: ice_cream_price
        }
      }
    end

    context 'with valid params' do
      it 'calls the ProcessDay service' do
        expect(ProcessDay).to receive(:new).with(game, strong_params).and_call_original

        post :create, params: day_params
      end

      it 'redirects to the game' do
        post :create, params: day_params

        expect(response).to redirect_to game
      end
    end

    context 'with invalid params' do
      before do
        game.inventory.update!(balance: 0.01)
      end

      it 'renders the new template' do
        post :create, params: day_params

        expect(response).to render_template :new
      end
    end
  end
end
