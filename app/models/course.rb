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

  def count_dossiers_with_status(status)
    Course.joins(:dossiers)
      .where("courses.id" => self.id)
      .where("dossiers.aasm_state" => status).count
  end

  def count_actions_this_past_week_by_status(status)
    time_range = (Time.now.midnight - 7.day)..Time.now
    Course.joins(dossiers: :dossier_statuses)
        .where('dossier_statuses.status' => status)
        .where('courses.id' => self.id)
        .where('dossier_statuses.created_at' => time_range)
        .count
  end


end
