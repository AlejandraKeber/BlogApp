# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :manage, Post, author_id: user.id # User can delete their own posts
    can :destroy, Post if user.role == 'admin' # Admin can delete any post
    can :manage, Comment, author_id: user.id # User can delete their own comments
    can :destroy, Comment if user.role == 'admin' # Admin can delete any comment
  end
end
