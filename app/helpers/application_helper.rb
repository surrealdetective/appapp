module ApplicationHelper
  def title
    if @title
      "#{@title} | App App"
    else
      "App App"
    end
  end
end
