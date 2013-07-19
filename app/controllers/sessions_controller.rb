class SessionsController < ApplicationController
  
  skip_before_filter :login_required, :only => [:new, :create]

  def new #this happens when you login
  end

  def create#this is the post, which creates your login
    user = User.where(:email => params[:user][:email]).first
    #raise user.inspect
    if user
      #raise params.inspect
      redirect_to user_path(user)
      login(user)
    else
      flash[:notice] = "Could not authenticate for #{params[:email]}"
      render :new
    end
  end

  def destroy
  end


end
