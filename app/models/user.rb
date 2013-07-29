class User < ActiveRecord::Base
  
  ROLES = {:admin => 0, :moderator => 100, :applicant => 200}
  attr_accessible :email, :first_name, :last_name, :dossiers, :password, :password_confirmation, :roles
  has_many :dossiers
  has_many :dossier_comments # meaning, they've written many
  has_many :hashtags

  has_secure_password

  # attr_accessor :password
  # before_save :encrypt_password

  # validates :email, :presence => true, :uniqueness => true
  # validates :name, :presence => true
  # validates_confirmation_of :password
   validates_presence_of     :password, :on => :create

  def save_with_dossier_status(status_text)
    last_dossier.add_status(status_text)
    self.save
  end

  # def most_recent_dossier_by_status(status = "reviewed")
  #   self.dossiers.most_recent.filter_by(status).first#.tagline or whatever
  # end

  def last_dossier
    self.dossiers.last
  end

  def self.all_sorted(attribute = "name", direction = "ASC")
    self.order("#{attribute} #{direction}")
  end

  def self.filter_by_status(status)
    self.all.keep_if{|user| user.status.status == status}
  end

  def has_dossiers?
    self.dossiers.count > 0
  end

  def status
    if has_dossiers?
      last_dossier.last_status
    else
      DossierStatus.new
    end

    # lets rewrite with joins
    # when you call like... User.first.status
    # it should find that users' last status
    # join this user to its dossiers, and its dossiers to *its* statuses
    # then find the most recent status
    # if there are no statuses, return a new status still?
    # self.dossiers.order("created_at ASC").joins(:dossier_statuses).order("dossier_statuses.created_at ASC").limit(1)
    # self.dossiers.includes(:dossier_statuses).order("created_at ASC").limit(1

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




  #ROLES = {:admin => 0, :moderator => 100, :applicant => 200}

  #the column is called roles bc user may have > 1 role.

  #Avi's method for setting permissions
  def set_role(role)
    self.update_attributes({:roles => self.class.roles[role]})
  end

  # My method, should be equivalent to Avi's above.
  # def roles=(role)
  #   @roles = User.roles[role]
  # end

  #class method to read ROLES
  def self.roles
    ROLES
  end

  # def roles
  #   ROLES[]
  # end

  #if the person's row column is lower than the passed-in role,
  #then they have that passed-in role's permissions, so yes.
  def role?(role)
    true if self.roles <= ROLES[role]
  end

  #again, putting roles on a scale shows that a user w/ a 
  #low integer role also has all the higher-intger role permissions

  def full_name
    "#{first_name} #{last_name}"
  end


end
