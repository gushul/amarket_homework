# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Performances::IndexService, type: :service do
  describe '#call' do
    subject(:call) { described_class.call(page:, per_page:) }

    let(:page) { 1 }
    let(:per_page) { 3 }
    let(:total_pages) { 1 }
    let(:expected_data) { [] }
    let(:expected_response) do
      {
        current_page: page,
        data: expected_data,
        per_page:,
        total_pages:
      }
    end

    context 'when there are no performances' do
      it 'returns empty array' do
        expect(call).to eq(expected_response)
      end
    end

    context 'when there are a performance' do
      let!(:performance) { create(:performance) }
      let(:expected_data) { [performance] }

      it 'returns array with performances' do
        expect(call).to eq(expected_response)
      end
    end

    context 'when there are performances' do
      before do
        create(:performance)
      end

      let!(:performance_2) do
        create(:performance, start_date: Time.zone.today + 2.days, end_date: Time.zone.today + 3.days)
      end
      let!(:performance_3) do
        create(:performance, start_date: Time.zone.today + 4.days, end_date: Time.zone.today + 5.days)
      end
      let!(:performance_4) do
        create(:performance, start_date: Time.zone.today + 6.days, end_date: Time.zone.today + 7.days)
      end

      let(:expected_data) { [performance_4, performance_3, performance_2] }
      let(:total_pages) { 2 }

      it 'returns array with performances' do
        expect(call).to eq(expected_response)
      end
    end
  end
end
