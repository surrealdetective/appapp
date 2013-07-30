class Course < ActiveRecord::Base
  attr_accessible :season, :seats, :subject

  has_many :dossiers

  #reads the class name
  def semester
    "#{self.subject} #{self.season}"
  end

  def self.list_for_selectbox
    self.all.collect do |course|
      [course.semester, course.id]
    end
  end

end
