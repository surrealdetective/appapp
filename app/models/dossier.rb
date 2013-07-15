class Dossier < ActiveRecord::Base
  attr_accessible :tagline, :user_id
  belongs_to :user
end
