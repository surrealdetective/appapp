class Interview < ActiveRecord::Base
  attr_accessible :dossier_id, :stage, :user_id, :dossier, :user
  belongs_to :dossier
  belongs_to :user

#finds the last interview and it's interview time
  def self.with_dossier(dossier)
    last_interview = self.where(:dossier_id => dossier.id).last #.where("interview_time >= :today", {today: Date.today})
    if last_interview
      return "No Interview Scheduled" unless last_interview.interview_time != nil
      last_interview.interview_time    
    else
      return "No Interview Scheduled"
    end
  end


end


# time_till_interview = time_ago_in_words(DateTime.now - #interview-time.to_datetime