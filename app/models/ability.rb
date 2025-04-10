# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.has_role?(:admin)
      can :manage, :all
    else
      can :read, Post
      # hoặc can :create, Post
    end
  end
end