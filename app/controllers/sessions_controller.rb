class SessionsController < ApplicationController
  def new #this happens when you login
  end

  def create #this is the post, which creates your login
    #if login success, continue to page
    #if login fail, go to new
    if current_user
      session[:user_id] = @current_user.id
      redirect_to user_path(current_user) #goto your user#show
    else
      redirect_to new_user_path #sign up
    end
  end

  def destroy
  end
end
