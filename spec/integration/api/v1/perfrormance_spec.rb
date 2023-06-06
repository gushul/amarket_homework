require 'swagger_helper'

describe 'Performances API' do
  path '/api/v1/performances' do
    post 'Creates a performance' do
      tags 'Performances'
      consumes 'application/json'
      parameter name: :performance, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, nullable: false },
          start_date: { type: :string, nullable: false, format: 'date', example: '2020-01-01' },
          end_date: { type: :string, nullable: false, format: 'date', example: '2020-01-01'  },
        },
        required: ['title', 'start_date', 'end_date']
      }

      response '201', 'performance created' do

        let(:performance) { attributes_for(:performance) }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:performance) { { title: 'Hamlet' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response '422', 'performance dates overlap' do
        before do
          create(:performance)
        end
        let(:performance) { attributes_for(:performance, start_date: Date.tomorrow, end_date: Date.today) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end

    get 'Retrieves performances' do
      tags 'Performances'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, description: 'Page number'
      parameter name: :per_page, in: :query, type: :integer, description: 'Number of items per page'

      let(:page) { 1 }
      let(:per_page) { 3 }
      response '200', 'performances found' do
        before do
          create(:performance)
          create(:performance, start_date: Date.today + 2.day, end_date: Date.today + 3.day)
          create(:performance, start_date: Date.today + 4.day, end_date: Date.today + 5.day)
        end

        schema( type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                properties: {
                  title: { type: :string },
                  start_date: { type: :string, format: 'date' },
                  end_date: { type: :string, format: 'date' },
                  created_at: { type: :string, format: 'date-time' },
                  updated_at: { type: :string, format: 'date-time' },
                },
              }
            },
            current_page: { type: :integer },
            per_page: { type: :integer },
            total_pages: { type: :integer },
          },
          required: [ 'data', 'current_page', 'per_page', 'total_pages' ]
              )


        run_test!
      end
      response '200', 'performances found, page 2' do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/performances/{id}' do
    delete 'Removes a performance' do
      tags 'Performances'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '204', 'performance deleted' do
        let(:id) { create(:performance).id }
        run_test!
      end

      response '404', 'performance not found' do
        let(:id) { 'invalid' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end

