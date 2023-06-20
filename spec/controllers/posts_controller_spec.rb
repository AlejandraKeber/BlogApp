require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user) { User.create(id: 1, name: 'Tom', photo: 'https://photo.com', bio: 'Teacher for test') }
  let!(:post) { Post.find_or_create_by(author_id: user.id, title: 'Post for test', text: 'This is test') }

  describe 'GET #index' do
    it 'returns a successful response' do
      get "/users/#{user.id}/posts"
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template('index')
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Here is a list of your posts')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template('shared/_user')
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('!DOCTYPE html')
    end
  end
end
