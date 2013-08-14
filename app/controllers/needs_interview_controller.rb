class NeedsInterviewController < ApplicationController
  
  #find 3 groups of dossiers and categorize them differently
  #uninvited dossiers => reject/send email
  #invited dossiers with no schedule => resend email / ?
  #invited dossiers with a schedule => resend email / skype
  #inivted dossiers past interview => reject / needs decision

  #SIMPLIFY::

  #by Primary Action:
  #1. send them an email
  #2. Skype/Badger them.         (they've been sent an interview time)
  #3. Needs Decision them.       (move them to the next page)

  def index
    @dossiers_with_decision = Dossier.joins(:interviews)
    .where("interviews.interview_time <= :today", {today: DateTime.now})
    .where("dossiers.aasm_state = ? OR dossiers.aasm_state = ?", "needs_interview", "needs_code_interview")
    .includes(:dossier_statuses, :hashtags)
    
    @dossiers_with_interview_time = Dossier.joins(:interviews)
    .where("interviews.interview_time >= :today", {today: DateTime.now})
    .where("dossiers.aasm_state = ? OR dossiers.aasm_state = ?", "needs_interview", "needs_code_interview")
    .includes(:dossier_statuses, :hashtags, :user)

    @dossiers_with_interview_without_time = Dossier.joins(:interviews).where("interviews.interview_time" => nil)
   .includes(:dossier_statuses, :hashtags, :user)

    dossier_with_interviews = @dossiers_with_decision + @dossiers_with_interview_time + @dossiers_with_interview_without_time
    @dossiers_without_interview = Dossier.where("dossiers.aasm_state=? OR dossiers.aasm_state =?", "needs_interview", "needs_code_interview").includes(:dossier_statuses, :hashtags, :user) - dossier_with_interviews

    @title = "Needs Interview Index"
    authorize! :index, @dossiers    
  end

  def email
    @user = User.find_by_id(params[:recipient])
    email_to_send = params[:email]
    case email_to_send
    when "reminder"
      UserMailer.reminder_email(@user).deliver
    when "reschedule"
      UserMailer.reschedule_email(@user).deliver
      interview_state = Interview.find_by_dossier_id(@user.last_dossier.id)
      interview_state.interview_time = nil
      interview_state.save
    end
    redirect_to :back
  end

end