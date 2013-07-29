class Hashtag < ActiveRecord::Base
  attr_accessible :content, :dossier_id, :user_id

  belongs_to :dossier
  belongs_to :user
end
