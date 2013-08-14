class Dossier < ActiveRecord::Base
  attr_accessible :aasm_state, :tagline, :phone_number, :city, :twitter,
                  :linkedin, :blog, :github, :website, :other_links,
                  :nyc,
                  :career, :purpose, :code_skills, :analytic_skills, :tidbits,
                  :user_id, :course, :skype, :gender, :course_id,
                  :codeschool_link, :treehouse_link
  belongs_to :user
  has_many :dossier_statuses
  has_many :dossier_comments
  belongs_to :course
  has_many :comments
  has_many :user_dossier_hashtags
  has_many :hashtags, through: :user_dossier_hashtags
  has_many :interviews
  has_one  :score

  validates_presence_of :tagline
  validates_presence_of :purpose
  validates_presence_of :analytic_skills
  validates_presence_of :career
  validates_presence_of :code_skills
  validates_presence_of :skype

  #validates_numericality_of :phone_number
  # validates :phone_number, :presence => true, :format => { :with => /\d{11}/, :on => :create, :message => "is invalid. Please include the area code" }
  # before_validation(:on => :create) do
  #   num = phone_number.gsub(/\D/, '')
  #   num.prepend("1") if num.length == 10
  # end

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

    # needs_review:
    # the application has been read and not rejected
    state :needs_review, :after_enter => Proc.new { |d| d.add_status "needs review"}


    # needs_interview:
    # not quite ready to make a decision
    state :needs_interview, :after_enter => Proc.new { |d| d.add_status "needs interview"}

    # needs_code_interview:
    state :needs_code_interview, :after_enter => Proc.new { |d| d.add_status "needs code interview" }

    # needs_decision:
    state :needs_decision, :after_enter => Proc.new { |d| d.add_status "needs decision" }



                                                    # # needs_decision_from_interview:
                                                    # # due diligence is done so now we need to make up our mind
                                                    # state :needs_decision_from_interview, :after_enter => Proc.new { |d| d.add_status "needs decision from interview"}

                                                    # # needs_decision_from_interview:
                                                    # # due diligence is done so now we need to make up our mind
                                                    # state :needs_decision_from_code_interview, :after_enter => Proc.new { |d| d.add_status "needs decision from code interview"}

    # needs_payment:
    # accepted but has not yet confirmed, by paying
    state :needs_payment, :after_enter => Proc.new { |d| d.add_status "accepted"; d.add_status "needs payment"}

    # committed:
    # one of the three final states (the nicer one)
    state :committed, :after_enter => Proc.new { |d| d.add_status "committed"}

    # rejected:
    # another final state
    state :rejected, :after_enter => Proc.new { |d| d.add_status "rejected"}

    # wont_attend
    # we offered but they did not commit
    state :wont_attend, :after_enter => Proc.new { |d| d.add_status "won't attend"}

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

    # mark_as_needs_code_interview:
    # first interview took place
    # another is necessary
    event :mark_as_needs_code_interview do
      transitions :from => [ :needs_decision, :needs_interview], :to => :needs_code_interview
    end

    event :mark_as_needs_decision do
      transitions :from => [:needs_interview, :needs_code_interview], :to => :needs_decision
    end    

                                    # # mark_as_needs_decision:
                                    # # interview took place and now it's decision time
                                    # # this means no code interview will take place
                                    # event :mark_as_needs_decision_from_interview do
                                    #   transitions :from => :needs_interview, :to => :needs_decision_from_interview
                                    # end

                                    # event :mark_as_needs_decision_from_code_interview do
                                    #   transitions :from => :needs_code_interview, :to => :needs_decision_from_code_interview
                                    # end

                                    # # actually_we_still_need_a_code_interview
                                    # # incorrectly moved to needs_decision w/o a code interview
                                    # event :actually_we_still_need_a_code_interview do
                                    #   transitions :from => :needs_decision_from_interview, :to => :needs_code_interview
                                    # end


    # mark_as_accepted:
    # decision takes place and now it's payment pending
    event :mark_as_accepted do
      transitions :to => :needs_payment
    end

    # mark_as_committed:
    # they paid and will attend
    event :mark_as_committed do
      transitions :from => :needs_payment, :to => :committed
    end

    # are there cases where a person decides not to attend before flatiron has accepted them?
    # probs.
    # can add another event
    event :mark_as_wont_attend do
      transitions :from => :needs_payment, :to => :wont_attend #possibly add this after transitions > :from => :needs_payment, 
    end

    event :mark_as_rejected do
      transitions :to => :rejected
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
      transitions :to => :needs_payment
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
    when :interview_created_at
      self.joins(:interviews).order("interviews.created_at #{direction}")
    when :interview_stage
      self.joins(:interviews).order("interviews.stage #{direction}")
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
    Dossier.where(aasm_state: state).group(:id).having("id < ?", self.id).last
  end

  def twitter_url
    "https://twitter.com/#{twitter}"
  end

  def word_count
    self.attributes.values.inject {|sum, value| sum += value.to_s.length}
  end

  def link_count
    link_count = 0
    [self.twitter, self.github, self.codeschool_link, self.treehouse_link, self.blog, self.linkedin, self.website].each do |link|
      link_count += 1 if link.present?
    end
    link_count.to_s + "/7"
  end

  # [new, needs_review, needs_interview, needs_code_interview, needs_decision, needs_payment, committed, rejected, wont_attend] 
  def random_status!
    
    choice = [:new, :needs_review, :needs_interview, :needs_interview, :needs_code_interview, :needs_decision, :needs_payment, :committed, :rejected, :rejected, :rejected, :rejected, :wont_attend, :wont_attend].sample
    return if choice == :new

    #convention: after setting the state, return if the choice equals that.
    self.mark_as_needs_review
    return if choice == :needs_review

    self.mark_as_needs_interview

    if choice == :needs_interview
      return
    elsif choice == :needs_code_interview
      self.mark_as_needs_code_interview
      return
    end

    self.mark_as_needs_decision
    return if choice == :needs_decision

    self.mark_as_accepted

    return if choice == :needs_payment
    
    self.mark_as_committed

    return if choice == :committed

    

    if choice == :rejected
      self.mark_as_rejected
      return
    elsif choice == :rejected
      self.mark_as_wont_attend
      return
    end

    #add rejected and wont_attend later.
    # if choice == :needs_decision_from_interview
    #   self.mark_as_needs_decision_from_interview
    #   return
    # elsif choice == :needs_decision_from_code_interview
    #   self.mark_as_needs_code_interview
    #   self.mark_as_needs_decision_from_code_interview
    #   return
    # end
    
  end

  def semester
    self.course.semester
  end

  def read_interview_time
    possible_interview_object = self.interviews.last
    if possible_interview_object.respond_to?(:interview_time)
      possible_interview_object.interview_time
    else
      "NA"
    end
  end

  def add_hashtag(str, commentor)
    UserDossierHashtag.create(
        :hashtag => Hashtag.find_or_create_by_content(str),
        :dossier => self,
        :user    => commentor
      )
  end

  def self.with_hashtag(query)
    joins(:hashtags).where("hashtags.content = ?", query)
  end

  # does this implementation make sense?
  # I wanted to be slightly smarter when people search by name
  def self.with_user_name(name)
    words = name.split(" ")
    if words.length == 2
      fuzzy_first_name = "%#{words.first}%"
      fuzzy_last_name = "%#{words.last}%"
      joins(:user).where("users.first_name like ? and users.last_name like ?", fuzzy_first_name, fuzzy_last_name)
    else
      fuzzy_name = "%#{name}%"
      joins(:user).where("users.first_name like ? or users.last_name like ?", fuzzy_name, fuzzy_name)
    end
  end

  def self.with_status(query)
    if query == "needs_interview_and_code_interview"
      where("aasm_state = ? OR aasm_state = ?", "needs_interview", "needs_code_interview")
    else
      where("aasm_state = ?", query)
    end
  end

  def aasm_events_with_extras
    events = self.aasm.events.map{|e| e.to_s }
    events += ["reject", "accept"] unless ["accepted", "committed", "rejected", "wont_attend", "needs_payment"].include? self.aasm_state
    events
  end

  def last_interview_time
    Interview.with_dossier(self)
  end

  def links
    [{"Twitter: " => self.twitter},{"Github: " => self.github}, {"LinkedIn: " => self.linkedin}, {"Blog: " => self.blog}, {"Website: " => self.website}, {"Codeschool: " => self.codeschool_link}, {"Treehouse: " => self.treehouse_link}]
  end

  def path_to_workflow
    case self.aasm_state
    when "new"
      Rails.application.routes.url_helpers.thinner_path
    when "needs_review"
      Rails.application.routes.url_helpers.needs_review_first_path
    when "needs_interview", "needs_code_interview"
      Rails.application.routes.url_helpers.dossier_interview_path
    when "needs_decision", "needs_payment", "committed"
      Rails.application.routes.url_helpers.course_path(self.course_id)
    when "rejected", "wont_attend"
      Rails.application.routes.url_helpers.dossiers_path(:status => self.aasm_state)
    end
  end

end
