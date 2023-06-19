require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'Alejandra',
      bio: 'Aspiring FullStack Dev',
      photo: 'https://unsplash.com/photos/iR3dtvKmwAw',
      posts_counter: 2
    )

    @user2 = User.create(
      name: 'Christopher',
      bio: 'FullStack Dev',
      photo: 'https://unsplash.com/photos/hodKTZow_Kk',
      posts_counter: 3
    )

    @user3 = User.create(
      name: 'Mohammad',
      bio: 'FullStack Dev',
      photo: 'https://unsplash.com/photos/h1BuNJZzpC8',
      posts_counter: 4
    )
  end

  describe 'user index paged' do
    it 'displays correct username' do
      visit users_path
      expect(page).to have_content('Alejandra')
      expect(page).to have_content('Christopher')
      expect(page).to have_content('Mohammad')
    end

    it 'shows user profile photo' do
      visit users_path
      expect(page).to have_css("img[src*='https://unsplash.com/photos/iR3dtvKmwAw']")
      expect(page).to have_css("img[src*='https://unsplash.com/photos/hodKTZow_Kk']")
      expect(page).to have_css("img[src*='https://unsplash.com/photos/h1BuNJZzpC8']")
    end

    it 'shows the correct number of posts' do
      visit users_path

      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 3')
      expect(page).to have_content('Number of posts: 4')
    end

    it 'shows the user_path when clicked' do
      visit users_path
      click_link 'Alejandra'
      expect(page).to have_current_path(user_path(@user1))
    end
  end
end
