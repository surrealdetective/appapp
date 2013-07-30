class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    @course = Course.create(params[:course])
    redirect_to courses_path
  end

  def index
    @pending = Dossier.where(:aasm_state => "needs_payment")
    authorize! :index, @pending
    @confirmed = Dossier.where(:aasm_state => "committed")
    @courses = Course.all
  end
end
