class NeedsInterviewController < ApplicationController
  def index
    if params[:search]
      @dossiers = Dossier.joins(:user).where(:users => {:first_name => params[:search]})
    else
      @dossiers = Dossier.sort_by(params[:sort_by])
    end
  end
end