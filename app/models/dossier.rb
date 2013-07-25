class Dossier < ActiveRecord::Base
  attr_accessible :aasm_state, :tagline, :phone_number, :city, :twitter,
                  :linkedin, :blog, :github, :website, :other_links,
                  :career, :purpose, :code_skills, :analytic_skills, :tidbits,
                  :user_id, :semester
  belongs_to :user
  has_many :dossier_statuses
  has_many :dossier_comments
  include AASM

  aasm do
                ###################
                ##### States ######
                ###################

    # new:
    # the application has been created
    # calls the dossier_is_new method
    # immediately after the record is persisted
    # (that method is currently at the bottom of this file)
    state :new, :initial => true, :after_enter => Proc.new { |d| d.add_status "new" }

    # thinning:
    # the application has not been approved for review
    # is this different from new?
    state :needs_thinning, :after_enter => Proc.new { |d| d.add_status "needs thinning"}

    # needs_review:
    # the application has been read and not rejected
    state :needs_review, :after_enter => Proc.new { |d| d.add_status "needs review"}

    # needs_interview:
    # not quite ready to make a decision
    state :needs_interview, :after_enter => Proc.new { |d| d.add_status "needs interview"}

    # needs_decision:
    # due diligence is done so now we need to make up our mind
    state :needs_decision, :after_enter => Proc.new { |d| d.add_status "needs decision"}

    # needs_decision:
    # due diligence is done so now we need to make up our mind
    state :needs_payment, :after_enter => Proc.new { |d| d.add_status "needs payment"}

    # accepted:
    # one of the two final states (the nicer one)
    state :accepted, :after_enter => Proc.new { |d| d.add_status "accepted~!"}

    # accepted:
    # one of the two final states (the nicer one)
    state :confirmed, :after_enter => Proc.new { |d| d.add_status "confirmed!!!"}

    # rejected:
    # the other final state
    state :rejected, :after_enter => Proc.new { |d| d.add_status "rejected :("}

            ###################
            ##### Events ######
            ###################

    # mark_as_needs_review:
    # looked over the email and it seems okay
    event :mark_as_needs_review do
      transitions :from => :new, :to => :needs_review
    end

    # mark_as_new:
    # kind of like marking an email as unread
    event :mark_as_new do
      transitions :from => :needs_review, :to => :new
    end

    # mark_as_needs_interview:
    # looking good so far, let's talk to this person
    event :mark_as_needs_interview do
      transitions :from => :needs_review, :to => :needs_interview
    end

        # mark_as_needs_decision:
    # interview took place and now it's decision time
    event :mark_as_needs_decision do
      transitions :from => :needs_interview, :to => :needs_decision
    end

    # mark_as_accepted:
    # decision takes place and now it's payment pending
    event :mark_as_accepted do
      transitions :from => :needs_decision, :to => :needs_payment
    end

    event :mark_as_confirmed do
      transitions :from => :needs_payment, :to => :confirmed
    end

    # reject:
    # note that there is no :from so reject
    # can be called from any state
    # awesome
    event :reject do
      transitions :to => :rejected
    end

    # accept:
    # same, can be called from any state
    event :accept do
      transitions :to => :accepted
    end

  end # end aasm block

  def add_status(status_text)
    self.dossier_statuses.build(status: status_text)
    self.save
  end

  def self.sort_by(column = :date, direction = "ASC")

    # setting to date twice
    # because sometimes we send in nil (eg, dossiers#index)
    # and "nil is the presence of absence" -ashley
    column ||= :date

    # TODO rewrite as something like:
    # case column
    # when /^user/
    #   meaning, it begins with user...
    #   which would allow us to specify which properties are user properties
    #   and not dossier ones

    case column.to_sym
    when :user
      self.joins(:user).order("users.first_name #{direction}")
    when :email
      self.joins(:user).order("users.email #{direction}")
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

  # self.most_recent
  # is a class method to get the most recent dossier of all the dossiers
  # eg:
  # Dossier.most_recent #=> [#<Dossier: aksjdfklajsdf>]
  def self.most_recent
    self.sort_by(:date, "DESC").limit(1)#.first
  end

  # last_status
  # get the last status object (not aasm_state, which returns a string)
  # for a particular dossier
  def last_status
    self.dossier_statuses.order("created_at DESC").limit(1).first
  end

  # self.first_with_state(state):
  # used by the application.html.erb layout file
  # to get the link to the first dossier that needs review
  # usage:
  # dossier = Dossier.first_with_state(:needs_review)
  def self.first_with_state(state)
    where(aasm_state: state).first
  end

  # next_with_state(state):
  # prev_with_state(state):
  # used in the needs_review show page
  # to link to the next dossier that needs review
  # usage:
  # dossier = Dossier.first
  # dossier.next_with_state(:needs_review)
  def next_with_state(state)
    Dossier.where(aasm_state: state).group(:id).having("id > ?", self.id).first
  end
  def prev_with_state(state)
    Dossier.where(aasm_state: state).group(:id).having("id < ?", self.id).first
  end

end
