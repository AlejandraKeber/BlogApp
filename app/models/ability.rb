# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    return unless user.present?
      
      can :create, Post
      can :update, Post, user_id: user.id
      can :destroy, Post, user_id: user.id

      return unless user.admin?
      can :manage, :all
  end
end
