class Hashtag < ActiveRecord::Base
  attr_accessible :content, :user

  has_many :user_dossier_hashtag
  has_many :dossiers, :through => :user_dossier_hashtag
  has_many :users, :through => :user_dossier_hashtag

  scope :with_content_like, ->(content) { where("content LIKE ?", "%#{content}%") }


end
