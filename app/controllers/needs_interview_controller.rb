class NeedsInterviewController < ApplicationController
  
 def show
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
 end

 def index
   @dossier = Dossier.find(params[:id])
   @user = @dossier.user
 end

end