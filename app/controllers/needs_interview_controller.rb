class NeedsInterviewController < ApplicationController
  def index
    #order the dossier methods by upcoming interviews.
    @dossiers = Dossier.joins(:interviews).where('dossiers.aasm_state' => ["needs_interview", "needs_code_interview"]).order('interviews.interview_time')
    # @dossiers = Dossier.where(:aasm_state => ["needs_interview", "needs_code_interview"])
    authorize! :index, @dossiers
  end
end