require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'User Test', photo: 'link', bio: 'Test Like model', posts_counter: 0)
  post = Post.create(author_id: user, title: 'Microverse', text: 'Ruby on Rails module', comments_counter: 0,
                     likes_counter: 0)
  subject { Like.new(user_id: user, post:) }

  before { subject.save }

  it 'Should increment likes counter for post' do
    prev_counter = subject.post.likes_counter
    subject.increment_post_likes_counter
    expect(subject.post.likes_counter) == prev_counter + 1
  end
end
