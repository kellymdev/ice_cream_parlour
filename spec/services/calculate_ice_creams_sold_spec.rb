require 'rails_helper'

RSpec.describe CalculateIceCreamsSold, type: :service do
  describe '#call' do
    let(:ice_creams_made) { 20 }
    let(:pedestrian_count) { 20 }
    let(:price) { 1.0 }
    subject(:service) { described_class.new(ice_creams_made, pedestrian_count, price) }

    context 'when the number of ice creams sold is less than the number of ice creams made' do
      let(:ice_creams_made) { 20 }

      it 'returns the number of ice creams sold' do
        expect(service.call).to eq 13
      end
    end

    context 'when the number of ice creams sold is more than the number of ice creams made' do
      let(:ice_creams_made) { 5 }

      it 'returns the number of ice creams made' do
        expect(service.call).to eq 5
      end
    end

    context 'based on price' do
      context 'when the price is between 0.00 and 0.50' do
        let(:price) { 0.45 }

        it 'uses a multiplier of 0.8' do
          expect(service.call).to eq 16
        end
      end

      context 'when the price is between 0.51 and 1.00' do
        let(:price) { 0.75 }

        it 'uses a multiplier of 0.65' do
          expect(service.call).to eq 13
        end
      end

      context 'when the price is between 1.01 and 1.50' do
        let(:price) { 1.25 }

        it 'uses a multiplier of 0.5' do
          expect(service.call).to eq 10
        end
      end

      context 'when the price is between 1.51 and 2.00' do
        let(:price) { 1.75 }

        it 'uses a multiplier of 0.4' do
          expect(service.call).to eq 8
        end
      end

      context 'when the price is between 2.01 and 5.00' do
        let(:price) { 2.25 }

        it 'uses a multiplier of 0.2' do
          expect(service.call).to eq 4
        end
      end

      context 'when the price is more than 5.00' do
        let(:price) { 5.50 }

        it 'uses a multiplier of 0.05' do
          expect(service.call).to eq 1
        end
      end
    end
  end
end
