require 'rails_helper'

RSpec.describe CalculatePedestrians, type: :service do
  describe '#call' do
    subject(:service) { described_class.new(temperature) }

    context 'when the temperature is between 10 and 15' do
      let(:temperature) { 10 }

      it 'returns a pedestrian count between 5 and 15' do
        expect(service.call).to be_between(5, 15)
      end
    end

    context 'when the temperature is between 16 and 20' do
      let(:temperature) { 18 }

      it 'returns a pedestrian count between 16 and 40' do
        expect(service.call).to be_between(16, 40)
      end
    end

    context 'when the temperature is between 21 and 25' do
      let(:temperature) { 23 }

      it 'returns a pedestrian count between 41 and 60' do
        expect(service.call).to be_between(41, 60)
      end
    end
  end
end
