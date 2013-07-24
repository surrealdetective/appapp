class ThinnerController < ApplicationController
  def index
    # @thinning = Users.where(:status => "")
    @dossier = Dossier.where(:id => 5).first
  end

  def testing

  end

  def decision
    raise params.inspect  
  end
end
