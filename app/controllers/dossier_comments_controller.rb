class DossierCommentsController < ApplicationController
  def create
    # raise params.inspect
    @dossier_comment = DossierComment.new(params[:dossier_comment])
    @dossier_comment.adds_hashtags
    # raise @dossier_comment.inspect
    @dossier_comment.save
    # redirect_to @dossier_comment.dossier
    redirect_to :back
  end

  def destroy
    
  end

  def edit
    
  end

  def update
    
  end
end

#there needs to be a place to store the hashtags
hashtag, which is a model


#content  #dossier_id  #user_id


#hashtags table
#id #content 



#join table: user-dossier-hashtags
#hashtag_id   dossier_id   user_id



