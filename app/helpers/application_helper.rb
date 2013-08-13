module ApplicationHelper
  def title
    if @title
      "#{@title} | App App"
    else
      "App App"
    end
  end

  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  def active?(controller, action)
    "active" if controller == params[:controller] && action == params[:action]
  end

  def stats_active?(status)
    "active" if params[:status] == status
  end

end
