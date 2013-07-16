class Dossier < ActiveRecord::Base
  attr_accessible :tagline, :user_id
  belongs_to :user
  has_many :dossier_statuses

  def add_status(status_text)
  	self.dossier_statuses.build(state: status_text)
  	self.save
  end
end
