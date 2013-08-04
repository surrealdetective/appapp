class WelcomeController < ApplicationController

  # you don't need to be logged in for this controller
  skip_before_filter :login_required

  def home

    if current_user
      if current_user.admin?
        redirect_to dashboard_path
      else
        if current_user.has_dossiers?
          redirect_to current_user.last_dossier
        else
          redirect_to new_dossier_path
        end
      end
    else
      redirect_to new_dossier_path
    end

  end
end
