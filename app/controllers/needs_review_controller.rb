class NeedsReviewController < ApplicationController

  def show
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
    authorize! :show, @user
    @title = @user.full_name
    @prev_dossier = @dossier.prev_with_state(:needs_review)
    @next_dossier = @dossier.next_with_state(:needs_review)

    # just in case you try to view someone's page who does NOT need review
    # how the heck did you get here?
    # get out of here
    # not sure if these 'and return's are necessary
    if !@dossier.needs_review?
      if @next_dossier
        redirect_to needs_review_show_path(@next_dossier)
      elsif @prev_dossier
        redirect_to needs_review_show_path(@prev_dossier)
      else
        redirect_to dashboard_path
      end
    end
  end

  def fancybox
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
    authorize! :show, @user
    @title = @user.full_name
    respond_to do |format|
      if params[:layout] == "false"
        format.html {render :layout => 'simple'}
      else
        format.html
      end
    end
  end

  def index
    @dossiers = Dossier.where(:aasm_state => "needs_review").sort_by(params[:sort_by])

    authorize! :index, @dossiers
  end

  def redirect_to_first
    # this route won't be linked from anywhere but in case they go to it,
    # it might as well redirect to the first dossier that needs review
    @first_that_needs_review = Dossier.first_with_state(:needs_review)
    if @first_that_needs_review
      redirect_to needs_review_show_path(@first_that_needs_review)
    else
      # does this make sense?
      # if there are zero that need review
      # maybe zooming back out to dashboard makes sense
      redirect_to dashboard_path
    end
  end

end
