class DossiersController < ApplicationController

  def new
    @user= User.find(params[:user_id])
    #raise @user.inspect

  end

  def create
    @user = User.find(params[:user_id])
    @user.dossiers.build(params[:dossier])
    @user.save_with_dossier_status("submitted")
    
    redirect_to @user
  end 


  def index
    case params[:sort_by]
    when "name"
      @dossiers = Dossier.sort_by_user
    when "app created at"
      @dossiers = Dossier.sort_by(:created_at)
    else
    	@dossiers = Dossier.all 
    end
    # raise @dossiers.inspect
    # @sorters = ["name", "status", "created_at"]
    # options_from_collection_for_select(@sorters, "id", "name")
    # raise params.inspect
  end
  
  # def filter
  #   raise params.inspect
  # end

  def filter_by
    if DossierStatus.list.include? params[:filter]
      @dossiers = Dossier.filter_by_status(params[:filter])
    else
      @dossiers = Dossier.all
    end
  end
  
end
