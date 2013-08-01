class ScoreController < ApplicationController
  def new
    @score = Score.new
  end

  def create
    #raise params.inspect
    @dossier = Dossier.find(params[:dossier_id])
    @dossier.build_score(params[:score])
    @dossier.save
    #   raise @dossier.inspect
    # else
    #   raise "WTF?"
    # end

    
    #@course = Course.new(params[:course])
    #@course.add_starting_date(params[:date])
    #@course.save
    #redirect_to courses_path
    redirect_to :back
  end

  def index
   # Course.all
  end

  def dashboard
   # @course = Course.first
  end
end