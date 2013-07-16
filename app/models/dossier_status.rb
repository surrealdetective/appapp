class DossierStatus < ActiveRecord::Base
  attr_accessible :state, :user_id
  belongs_to :user

  LIST_OF_STATUSES = ["created", "submitted", "reviewed", "accepted", "deferred", "declined"]

  def self.list
    LIST_OF_STATUSES
  end

end
