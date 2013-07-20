class DossiersController < ApplicationController

  # set a non-default layout for dossier viewing
  layout "dashboard"

  def new
    @user= User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @user.dossiers.build(params[:dossier])
    @user.save_with_dossier_status("submitted")
    
    redirect_to @user
  end 

  def index
    # raise params.inspect
    @dossiers = Dossier.sort_by(params[:sort_by])
    @title = "Admin Zone"
  end
  
  # def filter
  #   raise params.inspect
  # end

  def filter_by
    if DossierStatus.list.include? params[:filter]
      @dossiers = Dossier.filter_by(params[:filter])
    elsif params[:filter] == "all"
      @dossiers = Dossier.find(:all)
    else
      @dossiers = []
    end
  end
    
end
