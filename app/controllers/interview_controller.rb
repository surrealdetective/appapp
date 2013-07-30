class InterviewController < ApplicationController


  def show
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
  end
  
end
