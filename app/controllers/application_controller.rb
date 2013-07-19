class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required #check this

  def current_user
    @current_user = User.where(:email => params[:email]).first
  end

  #2 methods for login bc
  #login is where session[:user_id] is called
  def login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def login_required
    login
  end
end
