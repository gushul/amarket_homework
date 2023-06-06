# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Performance, type: :model do
  let(:performance) { build(:performance) }

  describe '#validations' do
    it 'validates presence of start_date' do
      performance.start_date = nil
      expect(performance).not_to be_valid
      expect(performance.errors.messages[:start_date]).to include("can't be blank")
    end

    it 'validates presence of end_date' do
      performance.end_date = nil
      expect(performance).not_to be_valid
      expect(performance.errors.messages[:end_date]).to include("can't be blank")
    end

    it 'validates that end_date is after start_date' do
      performance.start_date = Time.zone.today
      performance.end_date = Time.zone.today - 1.day
      expect(performance).not_to be_valid
      expect(performance.errors.messages[:base]).to include('start_date must be before end_date')
    end

    it 'validates that performance does not overlap with existing performances' do
      create(:performance, start_date: Time.zone.today, end_date: Time.zone.today + 1.day)
      performance.start_date = Time.zone.today
      performance.end_date = Time.zone.today + 1.day
      expect(performance).not_to be_valid
      expect(performance.errors.messages[:base]).to include('cannot overlap with existing performance')
    end

    it 'validates that start_date is not in the past' do
      performance.start_date = Time.zone.today - 1.day
      expect(performance).not_to be_valid
      expect(performance.errors.messages[:base]).to include('start_date cannot be in the past')
    end
  end
end
