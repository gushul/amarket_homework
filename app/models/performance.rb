# frozen_string_literal: true

class Performance < ApplicationRecord
  validates :title, :start_date, :end_date, presence: true
  validate  :validate_uniq_dates, :validate_start_date_before_end_date, :validate_start_not_in_past

  private

  def validate_start_not_in_past
    return if start_date.blank?

    return unless start_date < Time.zone.today

    errors.add(:base, 'start_date cannot be in the past')
  end

  def validate_uniq_dates
    return if start_date.blank? || end_date.blank?

    return unless Performance.where('start_date <= ? AND end_date >= ?', end_date, start_date).exists?

    errors.add(:base, 'cannot overlap with existing performance')
  end

  def validate_start_date_before_end_date
    return if start_date.blank? || end_date.blank?
    return unless start_date >= end_date

    errors.add(:base, 'start_date must be before end_date')
  end
end
