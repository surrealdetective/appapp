class User < ActiveRecord::Base
  
  has_many :dossiers

  attr_accessible :email, :name, :dossiers, :password, :password_confirmation
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









end