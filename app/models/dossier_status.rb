class DossierStatus < ActiveRecord::Base
  attr_accessible :status, :dossier_id
  belongs_to :dossier
  
  def self.list
    Dossier.aasm.states
  end

end
