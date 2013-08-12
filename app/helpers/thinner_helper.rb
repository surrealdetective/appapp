module ThinnerHelper
  def four_hundred_twenty_chars(str)
    if str.length >= 417
      str[0..415] + "..."
    else
      str[0..417]
    end
  end

  def one_hundred_forty_chars(str)
    str[0..139]
  end
end
