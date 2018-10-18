require 'rails_helper'

RSpec.describe DaysController, type: :controller do
  render_views

  let(:game) { create(:game) }

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
end
