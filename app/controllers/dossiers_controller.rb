class DossiersController < ApplicationController

  def new
  end

  def create
  end

  def index
  	@dossiers=Dossier.all 
  end


end
