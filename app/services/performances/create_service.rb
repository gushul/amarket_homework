# frozen_string_literal: true

module Performances
  class CreateService < ApplicationService
    def initialize(title:, start_date:, end_date:)
      @title = title
      @start_date = start_date
      @end_date = end_date
    end

    def call
      Performance.create!(title: @title, start_date: @start_date, end_date: @end_date)
    end
  end
end
