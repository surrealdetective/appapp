class ThinnerController < ApplicationController
  layout "thinner"
  
  def index
    @thinner = Dossier.where(:aasm_state => "new").limit(15)
  end

  def testing

  end

  def decision
    @dossier = Dossier.find_by_id(params[:dossier_id])
    decision = params[:commit]
    if decision == "Reject Now"
      @dossier.marks_as_rejected
    else
      @dossier.marks_as_needs_review
    end
    redirect_to thinner_path
  end
end
