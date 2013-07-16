class DossierStatus < ActiveRecord::Base
  attr_accessible :state, :dossier_id
  belongs_to :dossier

  LIST_OF_STATUSES = ["submitted", "reviewed", "accepted", "deferred", "declined"]

  def self.list
    LIST_OF_STATUSES
  end

end
