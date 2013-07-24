class NeedsInterviewController < ApplicationController
  
 def show
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
 end

 def index
   @dossier = Dossier.find(params[:id])
   @user = @dossier.user
   if params[:search]
      @dossiers = Dossier.joins(:user).where(:users => {:first_name => params[:search]})
    else
      @dossiers = Dossier.sort_by(params[:sort_by])
    end
 end

end