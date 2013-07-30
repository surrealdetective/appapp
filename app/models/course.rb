class Course < ActiveRecord::Base
  attr_accessible :season, :seats, :subject, :starting_date

  has_many :dossiers
  has_many :dossier_statuses, :through => :dossiers

  #reads the class name
  def semester
    "#{self.subject} #{self.season}"
  end

  def self.list_for_selectbox
    self.all.collect do |course|
      [course.semester, course.id]
    end
  end

  def add_starting_date(date_hash)
    year = date_hash[:year].to_i
    month = date_hash[:month].to_i
    day = date_hash[:day].to_i
    self.starting_date = Date.new(year, month, day)
  end

end
