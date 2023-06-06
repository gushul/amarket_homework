# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PerformancesController, type: :controller do
  let(:valid_attributes) { attributes_for(:performance) }
  let(:invalid_attributes) { { title: nil } }

  describe 'GET #index' do
    it 'returns a success response' do
      Performance.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Performance' do
        expect do
          post :create, params: { performance: valid_attributes }
        end.to change(Performance, :count).by(1)
      end

      context 'when performance exist on same date' do
        before do
          Performance.create! valid_attributes
        end

        it 'does not create a new Performance' do
          expect do
            post :create, params: { performance: valid_attributes }
          end.to change(Performance, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['error']['base']).to eq(['cannot overlap with existing performance'])
        end
      end
    end

    context 'with invalid parameters' do
      context 'with empty params' do
        it 'does not create a new Performance' do
          expect do
            post :create, params: { performance: invalid_attributes }
          end.to change(Performance, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['error'].keys).to match_array(%w[title start_date end_date])
        end
      end

      context 'with start date bigger than end date' do
        let(:invalid_attributes) do
          attributes_for(:performance, start_date: Time.zone.today + 1.day, end_date: Time.zone.today)
        end

        it 'does not create a new Performance' do
          expect do
            post :create, params: { performance: invalid_attributes }
          end.to change(Performance, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['error']['base']).to eq(['start_date must be before end_date'])
        end
      end

      context 'with wrong date format' do
        let(:invalid_attributes) { attributes_for(:performance, end_date: 'some-01-01') }

        it 'does not create a new Performance' do
          expect do
            post :create, params: { performance: invalid_attributes }
          end.to change(Performance, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['error']['end_date']).to eq(["can't be blank"])
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested performance' do
      performance = Performance.create! valid_attributes
      expect do
        delete :destroy, params: { id: performance.to_param }
      end.to change(Performance, :count).by(-1)
    end
  end
end
