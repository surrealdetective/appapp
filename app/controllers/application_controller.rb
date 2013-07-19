class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user = User.where(:email => params[:email]).first
  end
end
