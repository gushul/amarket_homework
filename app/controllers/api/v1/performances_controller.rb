# frozen_string_literal: true

module Api
  module V1
    class PerformancesController < ApplicationController
      def index
        @performances = ::Performances::IndexService.call(page: params[:page], per_page: params[:per_page])

        render json: @performances
      end

      def create
        performance = ::Performances::CreateService.call(
          title: performance_params['title'],
          start_date: performance_params['start_date'],
          end_date: performance_params['end_date']
        )

        render json: performance, status: :created
      end

      def destroy
        ::Performances::DestroyService.call(id: params[:id])

        head :no_content
      end

      def some(title:, start_date:, end_date:)
        Rails.logger.debug title
        Rails.logger.debug start_date
        Rails.logger.debug end_date
      end

      private

      def performance_params
        params.require(:performance).permit(:title, :start_date, :end_date)
      end
    end
  end
end
