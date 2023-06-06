# frozen_string_literal: true

module Performances
  class IndexService < ApplicationService
    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 10

    def initialize(page:, per_page:)
      @page = page || DEFAULT_PAGE
      @per_page = per_page || DEFAULT_PER_PAGE
    end

    def call
      performances = fetch_performances

      {
        data: performances,
        total_pages: performances.total_pages.to_i,
        current_page: @page.to_i,
        per_page: @per_page.to_i
      }
    end

    def fetch_performances
      Performance.order(start_date: :desc).paginate(page: @page, per_page: @per_page)
    end
  end
end
