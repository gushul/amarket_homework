# frozen_string_literal: true

module Api
  class HealthcheckController < ApplicationController
    def status
      @health = HealthService.new.status

      render json: { status: @health }
    end
  end
end
