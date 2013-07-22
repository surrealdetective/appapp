class DossierStatus < ActiveRecord::Base
  attr_accessible :status, :dossier_id
  belongs_to :dossier
  include AASM

  LIST_OF_STATUSES = ["saved", "submitted", "reviewed", "offer for 1st interview", "agreed to 1st interview", "interview pending", "offer for 2nd interview", "agreed to 2nd interview", "2nd interview pending", "accepted", "deferred", "declined"]

  def self.list
    LIST_OF_STATUSES
  end
  


  aasm do 
    state :saved, initial => true
    state :submitted
    state :reviewed
    state :offer_for_1st_interview
    state :agreed_to_1st_interview
    state :interview_pending
    state :offer_for_2nd_interview
    state :agreed_to_2nd_interview
    state :second_interview_pending
    state :accepted
    state :deferred
    state :declined

    event :new_class do
      transitions :from => :deferred, :to=> :accepted 
    end
    


    
  end

end
