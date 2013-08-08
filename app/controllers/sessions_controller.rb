class SessionsController < ApplicationController

  skip_before_filter :login_required, :only => [:new, :create]

  # sessions#new
  # GET login_path
  def new
    @title = "Login"
  end

  # sessions#create
  # POST login_path
  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:password]) 
      session[:user_id] = user.id
      if user.admin?
        redirect_to dashboard_path, :notice => "Welcome back, #{user.first_name}"
      else
        if user.has_dossiers?
          redirect_to user.last_dossier, :notice => "Welcome back"
        else
          redirect_to new_dossier_path, :notice => "Why not apply?"
        end
      end
    else
      flash[:error] = "Invalid email or password"
      redirect_to login_path
    end
  end

  # sessions#destroy
  # GET logout_path
  def destroy
    reset_session
    redirect_to login_path, :notice => "You are logged out"
  end

end
