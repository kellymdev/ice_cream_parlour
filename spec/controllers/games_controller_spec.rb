require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let!(:game) { create(:game) }

  describe '#index' do
    render_views

    it 'renders the index template' do
      get :index

      expect(response).to render_template :index
    end
  end

  describe '#new' do
    it 'renders the new template' do
      get :new

      expect(response).to render_template :new
    end
  end

  describe '#create' do
    let(:strong_params) do
      ActionController::Parameters.new(name: name).permit!
    end
    let(:game_params) do
      {
        game: {
          name: name
        }
      }
    end

    context 'with valid params' do
      let(:name) { 'Fabulous Ice Creams' }

      it 'calls the CreateGame service' do
        expect(CreateGame).to receive(:new).with(strong_params).and_call_original

        post :create, params: game_params
      end

      it 'creates a new game' do
        expect { post :create, params: game_params }.to change { Game.count }.by 1
      end

      it 'redirects to the game' do
        post :create, params: game_params

        expect(response).to be_redirect
      end
    end

    context 'with invalid params' do
      let(:name) { 'A' }

      it 'calls the CreateGame service' do
        expect(CreateGame).to receive(:new).with(strong_params).and_call_original

        post :create, params: game_params
      end

      it 'does not create a new game' do
        expect { post :create, params: game_params }.not_to change { Game.count }
      end

      it 'renders the new template' do
        post :create, params: game_params

        expect(response).to render_template :new
      end
    end
  end

  describe '#show' do
    it 'renders the show template' do
      get :show, params: { id: game.id }

      expect(response).to render_template :show
    end
  end

  describe '#destroy' do
    it 'deletes the game' do
      expect { delete :destroy, params: { id: game.id } }.to change { Game.count }.by(-1)
    end

    it 'redirects to the Games List' do
      delete :destroy, params: { id: game.id }

      expect(response).to redirect_to games_path
    end
  end
end
