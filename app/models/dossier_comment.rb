class DossierComment < ActiveRecord::Base
  # user refers to who wrote the comment
  attr_accessible :content, :dossier_id, :user_id
  belongs_to :dossier
  belongs_to :user




  
end
