class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_post_likes_counter

  def increment_post_likes_counter
    Post.increment_counter(:likes_counter, post_id)
  end
end
