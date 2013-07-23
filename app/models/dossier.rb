class Dossier < ActiveRecord::Base
  attr_accessible :aasm_state, :tagline, :phone_number, :city, :twitter, :linkedin, :blog, :github, :website, :other_links, :career, :purpose, :code_skills, :analytic_skills, :tidbits, :user_id
  belongs_to :user
  has_many :dossier_statuses
  has_many :dossier_comments
  include AASM

  def add_status(status_text)
    self.dossier_statuses.build(status: status_text)
    self.save
  end

  def self.sort_by(column = :date, direction = "ASC")
    column ||= :date # because sometimes we send in nil (eg, dossiers#index)
    case column.to_sym
    when :user
      self.joins(:user).order("users.name #{direction}")
    when :date
      self.order("created_at #{direction}")
      # extend in future to sort by more stuff
    else
      self.order("#{column} #{direction}")
    end
  end

  def self.filter_by(status)
    self.joins(:dossier_statuses).where(:dossier_statuses => {:status => status})
  end

  def self.most_recent
    self.sort_by(:date, "DESC").limit(1)#.first
  end

  def last_status
    self.dossier_statuses.last
  end

  aasm do
    #     state :sleeping, :initial => true, :before_enter => :do_something
    state :unread, :initial => true, :after_exit => :dossier_is_created
    state :read
    state :offerring_for_1st_interview
    state :agrees_to_1st_interview
    state :interview_pending
    state :offerring_for_2nd_interview
    state :agrees_to_2nd_interview
    state :second_interview_pending
    state :accepts
    state :defers
    state :declines

    def dossier_is_created
      self.add_status("pending")
    end

    event :reads do
      transitions :from => :unread, :to => :read
    end

    event :unreads do
      transitions :from => :read, :to => :unread
    end

  end
end
