class Ability
  include CanCan::Ability

#takes a user object
  def initialize(user)
    user ||= user.new #creates a guest user if user doesn't exist.
    #the admin can perform all actions
    if user.role? :admin
      can :manage, :all
    elsif user.role? :moderator
      can :read, :all
      can :update, Dossier
    else  
      #any user can read the dossier controller
      can :read, Dossier, :user_id => user.id
    end
  end
end

#note to self.
#iceboxing how to limit user's read ability to only the Dossier#new, login, and logout

#focus on getting roles to work.
# 
# # Course Topic permissions
# can :manage, Topic, :course_id => user.teaching_course_ids