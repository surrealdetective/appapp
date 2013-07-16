class User < ActiveRecord::Base
  attr_accessible :email, :name, :dossiers
  has_many :dossiers

  validates :email, :presence => true, :uniqueness => true   
  validates :name, :presence => true  

  def save_with_dossier_status(status_text)
    last_dossier.add_status(status_text)  
    self.save
  end

  def last_dossier
    self.dossiers.last
  end

  def self.all_sorted(attribute = :name)
    # pass a symbol to sort by
    # or :created_at maybe
    self.all.sort_by(&attribute)
  end

  def self.filter_by_status(status_state)
    self.all.keep_if{|user| user.status.state == status_state}
  end

  def status
    if self.last_dossier
      self.last_dossier.dossier_statuses.last
    else
      DossierStatus.new
    end
  end

end