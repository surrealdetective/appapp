class Course < ActiveRecord::Base
  attr_accessible :season, :seats, :subject, :starting_date

  has_many :dossiers
  has_many :dossier_statuses, :through => :dossiers
  has_many :avg_times
  has_many :scores, :through => :dossiers

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
      time_range = Time.now.midnight..Time.now
    when "yesterday"
      time_range = (Time.now.midnight-1.day)..Time.now.midnight
    when "this week"
      time_range = Time.now.beginning_of_week..Time.now
    when "last week"
      time_range = (Time.now.beginning_of_week - 1.week)..Time.now.beginning_of_week
    when "this month"
      time_range = Time.now.beginning_of_month..Time.now
    when "last month"
      time_range = (Time.now.beginning_of_month - 1.month)..Time.now.beginning_of_month
    end

    case status
    when "resolved"
      self.joins(:dossiers => :dossier_statuses)
          .where("dossier_statuses.status = ? or dossier_statuses.status = ? or dossier_statuses.status = ?", "accepted", "rejected", "won't attend")
          .where('dossier_statuses.created_at' => time_range)
          .count
    when "reviewed"
      self.joins(:dossiers => :dossier_statuses)
          .where("dossier_statuses.status = ? or dossier_statuses.status = ?", "needs interview", "needs code interview")
          .where('dossier_statuses.created_at' => time_range)
          .count
    else
      self.joins(:dossiers => :dossier_statuses)
          .where('dossier_statuses.status' => status)
          .where('dossier_statuses.created_at' => time_range)
          .count
    end
  end

  def count_all
    Course.joins(:dossiers).where("courses.id" => self.id).count
  end

  def gender_count
    gender_count = Course.joins(:dossiers).where("courses.id" => self.id).where("dossiers.gender = ? OR dossiers.gender = ? OR dossiers.gender = ?", "male", "female", "other")
    male_count = gender_count.where("dossiers.gender" => "male").count
    female_count = gender_count.where("dossiers.gender" => "female").count
    other_count = gender_count.where("dossiers.gender" => "other").count
    [male_count, female_count, other_count]
  end


  def score_count(attribute)
    score_counts = Score.joins(:dossier => :course).where("courses.id" => self.id)
    case attribute
    when :passion
      passion_count       = score_counts.where("scores.passion= ? OR scores.passion= ? OR scores.passion= ? OR scores.passion= ? OR scores.passion= ?", 1, 2, 3, 4, 5)
      [ passion_count.where("scores.passion" => 1).count, 
        passion_count.where("scores.passion" => 2).count,
        passion_count.where("scores.passion" => 3).count,
        passion_count.where("scores.passion" => 4).count,
        passion_count.where("scores.passion" => 5).count]
    when :leadership
      leadership_count        = score_counts.where("scores.leadership = ? OR scores.leadership = ? OR scores.leadership = ? OR scores.leadership = ? OR scores.leadership = ?", 1, 2, 3, 4, 5)
      [leadership_count.where("scores.leadership" => 1).count,
       leadership_count.where("scores.leadership" => 2).count,
       leadership_count.where("scores.leadership" => 3).count,
       leadership_count.where("scores.leadership" => 4).count,
       leadership_count.where("scores.leadership" => 5).count]
    when :tech
      tech_count = score_counts.where("scores.tech = ? OR scores.tech = ? OR scores.tech = ? OR scores.tech = ? OR scores.tech = ?", 1, 2, 3, 4, 5)
      [tech_count.where("scores.tech" => 1).count,
       tech_count.where("scores.tech" => 2).count,
       tech_count.where("scores.tech" => 3).count,
       tech_count.where("scores.tech" => 4).count,
       tech_count.where("scores.tech" => 5).count]
    end

  end
    


end
