require 'swagger_helper'

RSpec.describe 'competences', type: :request do
  before(:all) do
    Rails.application.load_seed
  end

  path '/competences' do

    get('list competences') do
      tags 'Competences'
      response(200, 'successful') do
        run_test!
      end
    end

    post('create competence') do
      tags 'Competences'
      consumes 'application/json'
      parameter name: :competence, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          course_ids: {
            type: :array, items: {
              type: :integer,
            }
          },
        },
        required: [ 'name' ]
      }
      response(200, 'successful') do
        let(:competence) { { name: 'Компетенция', course_ids: [1] } }
        run_test!
      end
      response(404, 'not found') do
        let(:competence) { { name: 'Компетенция', course_ids: [1] } }
        before do
          Course.find(1).destroy
        end
        run_test!
      end
      response(400, 'bad request') do
        let(:competence) { {  } }
        run_test!
      end
    end
  end

  path '/competences/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show competence') do
      tags 'Competences'

      response(200, 'successful') do
        let(:id) { 1 }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 0 }
        run_test!
      end
    end

    patch('update competence') do
      tags 'Competences'
      consumes 'application/json'
      parameter name: :competence, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          course_ids: {
            type: :array, items: {
              type: :integer,
            }
          },
        },
        required: [ 'name' ]
      }
      response(200, 'successful') do
        let(:id) { 1 }
        let(:competence) { { name: 'Компетенция', course_ids: [1] } }

        run_test!
      end
      response(400, 'bad request') do
        let(:id) { 1 }
        let(:competence) { {  } }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 0 }
        let(:competence) { { name: 'Компетенция', course_ids: [1] } }
        run_test!
      end
    end

    delete('delete competence') do
      tags 'Competences'
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
