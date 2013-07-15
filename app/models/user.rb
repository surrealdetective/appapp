class User < ActiveRecord::Base
  attr_accessible :email, :name, :dossiers
  has_many :dossiers

  def save_with_status(status)
    self.build_status(text: status)
    self.save
  end
  
end
