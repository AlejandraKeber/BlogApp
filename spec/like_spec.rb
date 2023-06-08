require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new(user_id: 1, post_id: 1) }

  it 'should update likes_counter on post' do
    user = User.create(name: 'Test User', posts_counter: 0)
    post = user.posts.build(title: 'Test Post', comments_counter: 0, likes_counter: 0)
    post.author_id = user.id
    like = post.likes.build(author_id: user.id)
    like.post_id = post.id
    post.save!
    like.save!
    Like.update_likes_counter(post.id)
    expect(Post.find(post.id).likes_counter).to eq(1)
  end
end
