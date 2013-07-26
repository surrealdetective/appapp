class WelcomeController < ApplicationController
  skip_before_filter :login_required
  layout "pretty"

  # lot of goofy conditionals here
  # rough draft
  
  def home

    if current_user
      if current_user.role?(:moderator)
        redirect_to dashboard_path
      else
        if current_user.last_dossier
          redirect_to current_user.last_dossier
        else
          redirect_to new_dossier_path
        end
      end
    end

    @title = "Welcome"
    @body_classes = "login-wrapper"

  end
end
