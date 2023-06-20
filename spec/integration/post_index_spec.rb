require 'rails_helper'
RSpec.describe 'Post index page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Alejandra', bio: 'Aspiring FullStack Dev', photo: 'https://unsplash.com/photos/iR3dtvKmwAw',
                        posts_counter: 2)
    @user2 = User.create(name: 'Christopher', bio: 'FullStack Dev', photo: 'https://unsplash.com/photos/hodKTZow_Kk',
                         posts_counter: 2)
    @post1 = Post.create(title: 'Test', text: 'First Post', comments_counter: 0, likes_counter: 0, author_id: @user.id)
    @post2 = Post.create(title: 'Test2', text: 'Second Post', comments_counter: 0, likes_counter: 0,
                         author_id: @user.id)
    @comment1 = Comment.create(text: 'First Comment', post_id: @post1.id, user_id: @user2.id)
    @comment2 = Comment.create(text: 'Second Comment', post_id: @post2.id, user_id: @user2.id)
    @like1 = Like.create(post_id: @post1.id, user_id: @user2.id)
  end

  describe 'the post index page' do
    it 'displays the users profile picture' do
      visit user_posts_path(@user)
      expect(page).to have_css("img[src*='https://unsplash.com/photos/iR3dtvKmwAw']")
    end

    it 'displays the users username' do
      visit user_posts_path(@user)
      expect(page).to have_content('Alejandra')
    end

    it 'displays the number of posts the user has written' do
      visit user_posts_path(@user)
      expect(page).to have_content('2')
    end

    it 'displays the post title' do
      visit user_posts_path(@user)
      expect(page).to have_content('Test')
      expect(page).to have_content('Test2')
    end

    it 'displays the post text' do
      visit user_posts_path(@user)
      expect(page).to have_content('First Post')
      expect(page).to have_content('Second Post')
      expect(page).to_not have_content('This post')
    end

    it 'displays the first comment' do
      visit user_posts_path(@user)
      expect(page).to have_content('First Comment')
    end

    it 'shows the first 5 comments' do
      visit user_posts_path(@user)
      expect(page).to have_css('.comment-body', maximum: 5)
    end

    it 'displays the number of comments' do
      visit user_posts_path(@user)
      expect(page).to have_content('2')
    end

    it 'displays the number of likes' do
      visit user_posts_path(@user)
      expect(page).to have_content('1')
    end

    it 'redirects to the post show page when clicked' do
      visit user_posts_path(@user)
      click_link 'First Post'
      expect(page).to have_current_path(user_post_path(@user, @post1))
    end
  end
end
