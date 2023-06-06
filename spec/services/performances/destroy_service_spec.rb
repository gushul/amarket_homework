# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Performances::DestroyService, type: :service do
  describe '#call' do
    subject(:call) { described_class.call(id:) }

    let(:performance) { create(:performance) }
    let!(:id) { performance.id }

    context 'when performance exists' do
      it 'destroys performance' do
        expect { call }.to change(Performance, :count).by(-1)
      end
    end

    context 'when performance does not exist' do
      let(:id) { 0 }

      it 'raises ActiveRecord::RecordNotFound' do
        expect { call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
