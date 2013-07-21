class SessionsController < ApplicationController

  skip_before_filter :login_required, :only => [:new, :create]

  def new #this happens when you login
    # render layout: false
  end

  def create#this is the post, which creates your login
    user = User.authenticate(params[:email], params[:password])
    #user = User.where(:email => params[:user][:email]).first
    #raise user.inspect
    if user
      #raise params.inspect
      login(user)
      redirect_to user_path(user)
      
    else
      flash[:notice] = "Could not authenticate for #{params[:email]}"
      redirect_to new_user_path
    end
  end

  def destroy
    reset_session
    redirect_to login_path, :notice => "You are logged out"

  end


end
