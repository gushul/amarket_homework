# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Healths API' do
  path '/api/healthcheck/ready' do
    get 'Returns health check ready' do
      tags 'Health'
      produces 'application/json'

      response '200', 'OK' do
        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
  path '/api/healthcheck/live' do
    get 'Returns health live status' do
      tags 'Health'
      produces 'application/json'

      response '200', 'OK' do
        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
