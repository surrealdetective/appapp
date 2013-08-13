class Interview < ActiveRecord::Base
  attr_accessible :dossier_id, :stage, :user_id, :dossier, :user
  belongs_to :dossier
  belongs_to :user

  def self.with_dossier(dossier)
    interview_time = self.where(:dossier_id => dossier.id).last #.where("interview_time >= :today", {today: Date.today})
    if interview_time
      interview_time     
    else
      return "No Interview Scheduled"
    end
  end


end
