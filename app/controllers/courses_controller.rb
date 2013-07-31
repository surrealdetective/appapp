class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    # raise params.inspect
    @course = Course.new(params[:course])
    @course.add_starting_date(params[:date])
    @course.save
    redirect_to courses_path
  end

  def index
    @pending = Dossier.where(:aasm_state => "needs_payment")
    authorize! :index, @pending
    @confirmed = Dossier.where(:aasm_state => "committed")
    @courses = Course.all
  end

  def dashboard
    @course = Course.first
  end
end
