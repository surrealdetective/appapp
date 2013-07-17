class DossierComment < ActiveRecord::Base
  attr_accessible :content, :dossier_id
  belongs_to :dossier
end
