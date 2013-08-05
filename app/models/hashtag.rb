class Hashtag < ActiveRecord::Base
  attr_accessible :content, :user

  has_one :user_dossier_hashtag
  has_one :dossier, :through => :user_dossier_hashtag
  has_one :user, :through => :user_dossier_hashtag

end
