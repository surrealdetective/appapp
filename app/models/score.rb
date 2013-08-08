class Score < ActiveRecord::Base
  attr_accessible :leadership, :passion, :tech, :dossier_id
  belongs_to :dossier
  belongs_to :course
end
