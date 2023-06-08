require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(user_id: 1, post_id: 1) }

  it 'should update comments_counter on post' do
    user = User.create(name: 'Test User', posts_counter: 0)
    post = user.posts.build(title: 'Test Post', comments_counter: 0, likes_counter: 0)
    post.author_id = user.id
    comment = post.comments.build(author_id: user.id)
    comment.post_id = post.id
    post.save!
    comment.save!
    Comment.update_comments_counter(post.id)
    expect(Post.find(post.id).comments_counter).to eq(1)
  end
end
