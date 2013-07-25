class DossierCommentsController < ApplicationController
  def create
    # raise params.inspect
    @dossier_comment = DossierComment.new(params[:dossier_comment])
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