class DossierCommentsController < ApplicationController
  def create
    @dossier_comment = DossierComment.new(params[:dossier_comments])
    # raise @dossier_comment.inspect
    @dossier_comment.save
    redirect_to @dossier_comment.dossier
  end

  def destroy
    
  end

  def edit
    
  end

  def update
    
  end
end