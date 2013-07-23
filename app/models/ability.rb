class Ability
  include CanCan:Ability

#takes a user object
  def initialize(user)
    
    #the admin can perform all actions
    if user.role? :admin
      can :manage, :all
    else
    
    #any user can read the dossier controller
    can :read, :dossier
  end
end

#note to self.
#iceboxing how to limit user's read ability to only the Dossier#new, login, and logout

#focus on getting roles to work.