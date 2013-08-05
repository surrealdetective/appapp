class NeedsInterviewController < ApplicationController
  def index
    #consider making a reads_interview method for dossier, which will protect us from nilling out.
    
    #what we want is below == @dossiers = Dossier.sort_by(params[:sort_by])

    if params[:sort_by] #some condition
      @dossiers_with_interviews = Dossier.joins(:interviews).where('dossiers.aasm_state' => ["needs_interview", "needs_code_interview"]).order('interviews.interview_time').sort_by(params[:sort_by])
      @dossiers_without_interviews = Dossier.where(:aasm_state => ["needs_interview", "needs_code_interview"]).sort_by(params[:sort_by])
      @dossiers = (@dossiers_with_interviews + @dossiers_without_interviews).uniq
    else
      #what is below: == @dossiers = Dossier.find(:all)
      @dossiers_with_interviews = Dossier.joins(:interviews).where('dossiers.aasm_state' => ["needs_interview", "needs_code_interview"]).order('interviews.interview_time')
      @dossiers_without_interviews = Dossier.where(:aasm_state => ["needs_interview", "needs_code_interview"])
      @dossiers = (@dossiers_with_interviews + @dossiers_without_interviews).uniq
    end
    @title = "Needs Interview Index"
    authorize! :index, @dossiers    
  end


end