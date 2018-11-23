require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  render_views

  let(:day) { create(:day) }
  let!(:milk) { create(:purchase, day: day) }
  let!(:sugar) { create(:purchase, day: day, ingredient: 'sugar') }

  describe '#index' do
    it 'renders the index template' do
      get :index, params: { day_id: day.to_param }

      expect(response).to render_template :index
    end
  end
end
