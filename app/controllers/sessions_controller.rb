class SessionsController < ApplicationController
  # layout "pretty"

  skip_before_filter :login_required, :only => [:new, :create]

  def new #this happens when you login
    # render layout: false
  end

  def create#this is the post, which creates your login
    #raise params.inspect
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:password]) 
      session[:user_id] = user.id
      if user.role?(:moderator)
        redirect_to dossiers_path, :notice => "Logged in!"
      else
        if user.last_dossier
          redirect_to user.last_dossier
        else
          redirect_to new_dossier_path
        end
      end
    else
       flash.now.alert = "Invalid email or password"
       render "new"
    end

  end

  def destroy
    raise session.inspect
    reset_session
    redirect_to login_path, :notice => "You are logged out"
  end


end
