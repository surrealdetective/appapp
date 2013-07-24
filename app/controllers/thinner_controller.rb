class ThinnerController < ApplicationController
  layout "thinner"
  
  def index
    @thinner = Dossier.where(:aasm_state => "new").limit(5)
    @dossier = Dossier.where(:id => 5).first
  end

  def testing

  end

  def decision
    raise params.inspect  
  end
end
