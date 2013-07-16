class Dossier < ActiveRecord::Base
  attr_accessible :tagline, :user_id
  belongs_to :user
  has_many :dossier_statuses

  def add_status(status_text)
  	self.dossier_statuses.build(state: status_text)
  	self.save
  end

  def self.sort_by(attribute)
		User.all_sorted ||= self.all.sort_by(&attribute)
  end

  def self.sort_by_tagline
  	self.all.sort_by{|dossier|dossier.tagline}
  end 

  def self.sort_by_status(status_text)
  	User.all.keep_if{|user|user.status.state == status_text}
  end 



end
