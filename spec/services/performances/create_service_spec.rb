# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Performances::CreateService, type: :service do
  describe '#call' do
    subject(:call) { described_class.call(**service_attributes) }

    let(:title) { Faker::Lorem.word }
    let(:end_date) { Time.zone.today + 1.day }
    let(:start_date) { Time.zone.today }

    let(:service_attributes) do
      {
        title:,
        start_date:,
        end_date:
      }
    end

    context 'when performance does not exist on same date' do
      it { expect { call }.to change(Performance, :count).by(1) }
    end

    context 'when performance exist on same date' do
      before do
        Performance.create! service_attributes
      end

      it 'returns a Performance with errors' do
        before_performance_count = Performance.count
        expect { call }.to raise_error(ActiveRecord::RecordInvalid, /cannot overlap with existing performance/)
        expect(Performance.count).to eq(before_performance_count)
      end
    end

    context 'when performance exist on one date' do
      before do
        Performance.create! service_attributes
      end

      let(:start_date) { Time.zone.today + 1.day }
      let(:end_date) { Time.zone.today + 2.days }

      it 'returns a Performance with errors' do
        before_performance_count = Performance.count
        expect { call }.to raise_error(ActiveRecord::RecordInvalid, /cannot overlap with existing performance/)
        expect(Performance.count).to eq(before_performance_count)
      end
    end
  end
end
