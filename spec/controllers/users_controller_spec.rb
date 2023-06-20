require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template('index')
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Welcome to your blog')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get '/users/1'
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get '/users/1'
      expect(response).to render_template('show')
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users/1'
      expect(response.body).to include('Hello')
    end
  end
end
