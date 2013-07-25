class NeedsReviewController < ApplicationController

  def show
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
    @title = @user.full_name
    @prev_dossier = @dossier.prev_with_state(:needs_review)
    @next_dossier = @dossier.next_with_state(:needs_review)
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
