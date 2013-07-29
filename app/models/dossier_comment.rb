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
      UserDossierHashtag.create(:user_id => commentor.id, :dossier_id => self.dossier_id, :hashtag_id => hashobject.id)
    end
  end


  
end

#In the controller

#From the view's perspective.
#Adam makes a comment with hash tags, and submits it.

#So in the ?controller?#create, that will parse using Twitter-text gem 

#we'll define a method that reads a comment, and stores its hashtags.

#then we'll use that method in the controller.

#two ways 
#1. is to write the method from 
#2. reads...? wrap it in a method



