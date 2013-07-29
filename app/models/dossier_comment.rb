class DossierComment < ActiveRecord::Base
  include Twitter::Extractor
  # user refers to who wrote the comment
  attr_accessible :content, :dossier_id, :user_id
  belongs_to :dossier
  belongs_to :user

  def adds_hashtags(commentor)
    hashtags = Twitter::Extractor.extract_hashtags(self.content)
    #write a line that adds each hashtag to a join table.
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



