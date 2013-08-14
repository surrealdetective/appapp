class ThinnerController < ApplicationController
  
  def index
    @title = "Glancer"
    @dossiers = Dossier.where(:aasm_state => "new").limit(8)
    authorize! :index, @thinner
  end

  def decision
    @dossier = Dossier.find_by_id(params[:dossier_id])
    decision = params[:commit]
    if decision == "Reject Now"
      @dossier.mark_as_rejected
    else
      @dossier.mark_as_needs_review
    end
    redirect_to thinner_path
  end
end
