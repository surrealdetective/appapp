class DossiersController < ApplicationController

  def new
    @user= User.find(params[:user_id])
    #raise @user.inspect

  end

  def create
    @user = User.find(params[:user_id])
    @user.dossiers.build(params[:dossier])
    @user.save
    
    redirect_to @user
  end 


  def index
  	@dossiers=Dossier.all 
  end

  
end
