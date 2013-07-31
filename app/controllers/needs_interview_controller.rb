class NeedsInterviewController < ApplicationController
  def index
    #consider making a reads_interview method for dossier, which will protect us from nilling out.
    @dossiers_with_interviews = Dossier.joins(:interviews).where('dossiers.aasm_state' => ["needs_interview", "needs_code_interview"]).order('interviews.interview_time')
    @dossiers_without_interviews = Dossier.where(:aasm_state => ["needs_interview", "needs_code_interview"])
    @dossiers = (@dossiers_with_interviews + @dossiers_without_interviews).uniq
    authorize! :index, @dossiers
  end


end