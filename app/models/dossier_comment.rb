class DossierComment < ActiveRecord::Base
  include Twitter::Extractor
  # user refers to who wrote the comment
  attr_accessible :content, :dossier_id, :user_id
  belongs_to :dossier
  belongs_to :user

  def adds_hashtags(commentor)
    hashtags = Twitter::Extractor.extract_hashtags(self.content)
    hashtags.each do |hashtag|
      hashobject = Hashtag.find_or_create_by_content(hashtag)
      UserDossierHashtag.create(:user => commentor, :dossier => self.dossier, :hashtag => hashobject)
    end
  end
  
end

