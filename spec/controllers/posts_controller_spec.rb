require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user) { User.create(id: 1, name: 'Tom', photo: 'https://photo.com', bio: 'Teacher for test') }
  let(:post) { Post.create(id: 4, author_id: user.id, title: 'Post for test', text: 'This is test') }

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
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template('show')
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Here is the  posts details for a given user')
    end
  end
end
