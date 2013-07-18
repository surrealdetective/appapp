class User < ActiveRecord::Base
  
  scope :early_adopters, -> { where(:id => [1..5]) }

  attr_accessible :email, :name, :dossiers
  has_many :dossiers

  validates :email, :presence => true, :uniqueness => true   
  validates :name, :presence => true  

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
    # self.dossiers.includes(:dossier_statuses).order("created_at ASC").limit(1)




  end


end