class Comment < ActiveRecord::Base
  attr_accessible :content, :dossier_id
end
