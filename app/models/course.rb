class Course < ActiveRecord::Base
  attr_accessible :season, :seats, :subject, :starting_date

  has_many :dossiers
  has_many :dossier_statuses, :through => :dossiers
  has_many :avg_times

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

  #when a dossier_status is updated, this method counts when that was created_at
  # a time_range must be passed to count when those created_at times were updated.
  def self.count_actions(status, time_range)
    case time_range
    when "today"
      time_range = (Time.now.midnight)..Time.now
    when "yesterday"
      time_range = (Time.now.midnight-1.day)..(Time.now.midnight)
    end
    self.joins(dossiers: :dossier_statuses)
        .where('dossier_statuses.status' => status)
        .where('dossier_statuses.created_at' => time_range)
        .count
  end

  def count_all
    Course.joins(:dossiers).where("courses.id" => self.id).count
  end


end
