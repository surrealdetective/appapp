class DossierCommentsController < ApplicationController
  def create
    @dossier_comment = DossierComment.new(params[:dossier_comment])
    @dossier_comment.adds_hashtags(current_user)
    @dossier_comment.save
    redirect_to :back
  end

  def destroy
    
  end

  def edit
    
  end

  def update
    
  end
end
