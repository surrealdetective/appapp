class Course < ActiveRecord::Base
  attr_accessible :season, :seats, :subject

  has_many :dossiers

  #reads the class name
  def semester
    "#{self.subject} #{self.season}"
  end
end
