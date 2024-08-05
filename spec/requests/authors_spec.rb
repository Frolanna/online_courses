require 'swagger_helper'

RSpec.describe 'authors', type: :request do

  path '/authors' do

    get('list authors') do
      tags 'Authors'
      response(200, 'successful') do
        run_test!
      end
    end

    post('create author') do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
        },
        required: [ 'name' ]
      }
      response(200, 'successful') do
        let(:author) { { name: 'Тест Тестов' } }
        run_test!
      end
      response(400, 'bad request') do
        let(:author) { }
        run_test!
      end
    end
  end

  path '/authors/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show author') do
      tags 'Authors'
      response(200, 'successful') do
        let(:id) { 1 }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 100 }
        run_test!
      end
    end

    patch('update author') do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
        },
        required: [ 'name' ]
      }
      response(200, 'successful') do
        let(:id) { 1 }
        let(:author) { { name: 'Тест1 Тестов' } }
        run_test!
      end
      response(400, 'bad request') do
        let(:id) { 1 }
        let(:author) { { } }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 0 }
        let(:author) { { name: 'Тест1 Тестов' } }
        run_test!
      end
    end

    delete('delete author') do
      tags 'Authors'
      response(204, 'successful') do
        let(:id) { 1 }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 0 }
        run_test!
      end
    end
  end
end
