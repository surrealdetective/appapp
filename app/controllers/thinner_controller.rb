class ThinnerController < ApplicationController
  def index
    @thinning = Users.where(:status => "")
  end
end
