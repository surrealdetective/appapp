class Ability
  include CanCan::Ability
  def initialize(user)
    # guest user
    user ||= User.new
    if user.admin?
      can :manage, :all
      cannot :update, Dossier
    else
      can :create, Dossier
      can :create, User
      can :update, Dossier do |dossier|
        dossier.user_id == user.id && dossier.aasm_state == "new"
      end
      can :read, Dossier, :user_id => user.id
    end
  end
end
