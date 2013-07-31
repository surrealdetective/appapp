class InterviewController < ApplicationController


  def show
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
  end

  def claim
    @dossier = Dossier.find(params[:id])
    Interview.create(user: current_user, dossier: @dossier, :stage => @dossier.aasm_state)

    if @dossier.needs_interview?
      UserMailer.interview_email(@dossier.user).deliver
    elsif @dossier.needs_code_interview?
      UserMailer.code_email(@dossier.user).deliver
    else
      puts "what?"
    end
    redirect_to :back
  end

  def schedule
    @days = Date.tomorrow..(Date.tomorrow+6.day)
  end

  def create
    @interview = Interview.where(:interview_time => nil).where(:dossier_id => params[:id]).first
    @interview.interview_time = params[:date]
    @interview.save
    redirect_to @interview.dossier
  end

  def index
    @interviews = Interview.joins(:dossier).where("dossiers.aasm_state" => ["needs_interview", "needs_code_interview"]).where("interviews.interview_time IS NOT NULL")
    #possibly, add a date cutoff, using orderby interview_time, then .last, since we assume only one interview occurs at a time.
    
  end
  
end
