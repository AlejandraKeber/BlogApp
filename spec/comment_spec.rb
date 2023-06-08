require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'User Test', photo: 'link', bio: 'Test Comment model', posts_counter: 0)
  post = Post.create(author_id: user, title: 'Microverse', text: 'Ruby on Rails module', comments_counter: 0,
                     likes_counter: 0)
  subject { Comment.new(user_id: user, post:) }

  before { subject.save }

  it 'should increment comments counter for post' do
    prev_counter = subject.post.comments_counter
    subject.increment_post_comments_counter
    expect(subject.post.comments_counter) == prev_counter + 1
  end
end
