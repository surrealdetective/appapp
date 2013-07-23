class SessionsController < ApplicationController
  layout "dashboard"
  skip_before_filter :login_required, :only => [:new, :create]

  def new #this happens when you login
    # render layout: false
  end

  def create#this is the post, which creates your login
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:password]) 
      session[:user_id] = user.id
      redirect_to dossiers_path, :notice => "Logged in!"    
    else
       flash.now.alert = "Invalid email or password"
       render "new"
    end

  end

  def destroy
    reset_session
    redirect_to login_path, :notice => "You are logged out"
  end


end
