class Hashtag < ActiveRecord::Base
  attr_accessible :content

  belongs_to :dossier
  belongs_to :user
end
