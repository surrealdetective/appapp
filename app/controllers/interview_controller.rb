class InterviewController < ApplicationController


  def show
    @dossier = Dossier.find(params[:id])

    #lets you look at only needs_interview or needs_code_interview pages.
    if @dossier.rejected? or @dossier.needs_decision?
      state = @dossier.dossier_statuses[-2].status.split.join('_').to_sym
    else
      state = @dossier.aasm_state
    end
    @prev_dossier = @dossier.prev_with_state(state)
    @next_dossier = @dossier.next_with_state(state)
    @user = @dossier.user
    @score = Score.new
    @title = "Interview #{@user.full_name}"
    respond_to do |format|
      if params[:layout] == "false"
        format.html {render :layout => 'simple'}
      else
        format.html
      end
    end
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
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
    @title = "Schedule interview with #{@user.full_name}"
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
    @title = "Interview Index"
  end
  
end
