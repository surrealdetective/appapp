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

  def mark_required(object, attribute)
  "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

end

  