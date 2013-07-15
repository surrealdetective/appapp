class User < ActiveRecord::Base
  attr_accessible :email, :name, :dossiers
  has_many :dossiers
  has_many :statuses

  def save_with_status(status_text)
    self.statuses.build(state: status_text)
    self.save
  end

  def self.all_sorted(attribute = :name)
    # pass a symbol to sort by
    # or :created_at maybe
    self.all.sort_by(&attribute)
  end

  def self.filter_by_status(status_state)
    self.all.keep_if{|user| user.statuses.last.state == status_state}
  end

end