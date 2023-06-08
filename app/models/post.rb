class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :author_id
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id

  after_create :increment_user_posts_counter

  def increment_user_posts_counter
    user.increment!(:post_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
