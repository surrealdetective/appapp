class DossierStatus < ActiveRecord::Base
  attr_accessible :status, :dossier_id
  belongs_to :dossier

  LIST_OF_STATUSES = ["saved", "submitted", "reviewed", "offer for 1st interview", "agreed to 1st interview", "interview pending", "offer for 2nd interview", "agreed to 2nd interview", "2nd interview pending", "accepted", "deferred", "declined"]

  def self.list
    LIST_OF_STATUSES
  end

end
