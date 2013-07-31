class Interview < ActiveRecord::Base
  attr_accessible :dossier_id, :stage, :user_id, :dossier, :user
  belongs_to :dossier
  belongs_to :user
end
