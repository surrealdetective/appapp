class ThinnerController < ApplicationController
  # removed this layout
  # layout "thinner"
  
  def index
    @dossier = Dossier.first
    # @thinner = Dossier.where(:aasm_state => "new").limit(3)
    authorize! :index, @thinner
  end

  def testing

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
