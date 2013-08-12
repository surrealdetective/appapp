class User < ActiveRecord::Base
  
  ROLES = {
    :admin =>     0,
    :applicant => 100
  }

  attr_accessible :email, :first_name, :last_name, :dossiers, :password, :password_confirmation, :roles, :gravatar_id
  has_many :dossiers
  has_many :dossier_comments # meaning, they've written many
  has_many :user_dossier_hashtags
  has_many :hashtags, through: :user_dossier_hashtags
  has_many :interviews

  has_secure_password

  # attr_accessor :password
  # before_save :encrypt_password

  validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :on => :create}
  
  validates_presence_of     :first_name, :on => :create, :message => "can't be empty"
  validates_presence_of     :last_name, :on => :create, :message => "can't be empty"
  validates_presence_of     :password, :on => :create
  # validates_confirmation_of :password

  def save_with_dossier_status(status_text)
    last_dossier.add_status(status_text)
    self.save
  end

  def last_dossier
    self.dossiers.last
  end

  def self.search(query)
    fuzzy_query = "%#{query}%"
    where("first_name LIKE ? or last_name LIKE ? or email LIKE ?", fuzzy_query, fuzzy_query, fuzzy_query)
  end

  def self.with_hashtag(query)
    fuzzy_query = "%#{query}%"
    joins(:dossiers => :hashtags).where("hashtags.content like ?", fuzzy_query)
  end

  def self.all_sorted(attribute = "name", direction = "ASC")
    self.order("#{attribute} #{direction}")
  end

  def self.with_status(status)
    joins(:dossiers => :dossier_statuses).where("dossier_statuses.status = ?", status)
  end

  def has_dossiers?
    self.dossiers.count > 0
  end

  # u = User.last
  # u.status
  # #=> the most recent dossier status object, or a generic one
  def status
    DossierStatus.joins(:dossier => :user)
                 .where("dossiers.user_id = ?", self.id)
                 .order("created_at DESC")
                 .limit(1)
                 .first || DossierStatus.new
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == Bcrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_role(role)
    self.update_attributes({:roles => self.class.roles[role]})
  end

  def self.roles
    ROLES
  end

  def admin?
    ROLES[:admin] == self.roles
  end

  def applicant?
    ROLES[:applicant] == self.roles
  end

end