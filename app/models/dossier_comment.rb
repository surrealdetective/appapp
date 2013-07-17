class DossierComment < ActiveRecord::Base
  attr_accessible :content, :dossier_id
end
