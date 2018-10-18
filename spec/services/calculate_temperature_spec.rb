require 'rails_helper'

RSpec.describe CalculateTemperature, type: :service do
  describe '#call' do
    subject(:service) { described_class.new(previous_temperature) }

    context 'when there is no previous temperature' do
      let(:previous_temperature) {}

      it 'returns a temperature between 10 and 25' do
        expect(service.call).to be_between(10, 25)
      end
    end

    context 'when there is a previous temperature' do
      let(:previous_temperature) { 20 }

      it 'returns a temperature between 10 and 25' do
        expect(service.call).to be_between(10, 25)
      end
    end
  end
end
