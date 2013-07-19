class SessionsController < ApplicationController
  def new #this happens when you login
  end

  def create#this is the post, which creates your login
    user = User.where(:email => params[:user][:email]).first
    raise user.inspect
    if user
      login(user)
      redirect_to user_path(user)
    else
      render :new
    end
  end

  def destroy
  end
end
