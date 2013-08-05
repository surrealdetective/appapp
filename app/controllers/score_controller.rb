class ScoreController < ApplicationController

  def create
    @dossier = Dossier.find(params[:dossier_id])
    @dossier.build_score(params[:score])
    @dossier.save
    redirect_to :back
  end

end