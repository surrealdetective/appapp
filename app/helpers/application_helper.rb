module ApplicationHelper
  def title
    if @title
      "#{@title} | App App"
    else
      "App App"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

  