class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user.present?
      can :manage, Post, user_id: user.id 
      can :manage, User, id: user.id

      if user.moderator?  # additional permissions for administrators
        can :manage, :all
      end
    end
  end
end
