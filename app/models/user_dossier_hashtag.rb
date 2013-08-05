class UserDossierHashtag < ActiveRecord::Base
   attr_accessible :user_id, :dossier_id, :hashtag_id, :user, :dossier, :hashtag

   belongs_to :dossier
   belongs_to :user
   belongs_to :hashtag
end
