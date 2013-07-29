class Course < ActiveRecord::Base
  attr_accessible :season, :seats, :subject

  has_many :dossiers
end
