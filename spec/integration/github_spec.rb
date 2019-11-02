
# spec/integration/pets_spec.rb
require 'swagger_helper'

describe 'GitHub API' do

  path '/api/v1/find' do

    get 'Retrieves a free_text' do
      tags 'Free_text'
      produces 'application/json', 'application/xml'
      parameter name: :free_text, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            photo_url: { type: :string },
            status: { type: :string }
          },
          required: [ 'id', 'name', 'status' ]

        let(:id) { Pet.create(name: 'foo', status: 'bar', photo_url: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'pet not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
