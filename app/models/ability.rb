class Ability
  include CanCan::Ability
  def initialize(user)
    # guest user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :create, Dossier
      can :create, User
      can :read, Dossier, :user_id => user.id
    end
  end
end
