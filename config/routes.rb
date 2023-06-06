# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  namespace :api, defaults: { format: :json } do
    get '/healthcheck/live', to: proc { [200, {}, %w[OK]] }
    get '/healthcheck/ready', to: 'healthcheck#status'

    namespace :v1 do
      resources :performances, except: %i[update show]
    end
  end
  get '/health_check', to: proc { [200, {}, ['success']] }
end
