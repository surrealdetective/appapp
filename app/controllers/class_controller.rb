class ClassController < ApplicationController
  def index
    # @pending = Dossier.limit(8)
    
    # @confirmed = Dossier.limit(5)
    @pending = Dossier.where(:aasm_state => "needs_payment")
    authorize! :index, @pending
    @confirmed = Dossier.where(:aasm_state => "committed")
  end

  def decision
  #   @dossier = Dossier.find_by_id(params[:dossier_id])
  #   decision = true if puts "payment has arrived"
  #   if decision == true
  #     @dossier.mark_as_confirmed
  #   else

  #   end
  end
end
