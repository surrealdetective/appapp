class WelcomeController < ApplicationController
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
    else
      # not logged in
      # show the two big buttons page
      @body_classes = "login-bg bg-login login-wrapper" # which is it...?
      @title = "Welcome"
    end
  end
end
