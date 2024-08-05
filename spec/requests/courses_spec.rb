require 'swagger_helper'

RSpec.describe 'courses', type: :request do
  before(:all) do
    Rails.application.load_seed
  end

  path '/courses' do

    get('list courses') do
      tags 'Courses'
      response(200, 'successful') do
        run_test!
      end
    end

    post('create course') do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          author_id: { type: :integer },
          competence_ids: {
            type: :array, items: {
              type: :integer,
            }
          },
        },
        required: [ 'name' ]
      }
      response(200, 'successful') do
        let(:course) { { name: 'Курс', competence_ids: [1], author_id: 1 } }
        run_test!
      end
      response(404, 'not found') do
        let(:course) { { name: 'Курс', competence_ids: [1], author_id: 1 } }

        before do
          Competence.destroy_all
        end
        run_test!
      end
      response(400, 'bad request') do
        let(:course) { {  } }
        run_test!
      end
    end
  end

  path '/courses/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show course') do
      tags 'Courses'
      response(200, 'successful') do
        let(:id) { 1 }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 0 }
        run_test!
      end
    end

    patch('update course') do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          author_id: { type: :integer },
          competence_ids: {
            type: :array, items: {
              type: :integer,
            }
          },
        },
        required: [ 'name' ]
      }
      response(200, 'successful') do
        let(:id) { 1 }
        let(:course) { { name: 'Курс', competence_ids: [1], author_id: 1 } }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 0 }
        let(:course) { { name: 'Курс', competence_ids: [1], author_id: 1 } }
        run_test!
      end
      response(400, 'bad request') do
        let(:id) { 1 }
        let(:course) { {  } }
        run_test!
      end
    end

    delete('delete course') do
      tags 'Courses'

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
