# frozen_string_literal: true

module Performances
  class DestroyService < ApplicationService
    def initialize(id:)
      @id = id
    end

    def call
      performance = Performance.find(@id)
      performance.destroy!
    end
  end
end
