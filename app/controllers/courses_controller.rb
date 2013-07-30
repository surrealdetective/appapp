class CoursesController < ApplicationController
  def new

  end

  def create
  end

  def index
    @courses = Course.all
    @pending = Dossier.where(:aasm_state => "needs_payment")
    authorize! :index, @pending
    @confirmed = Dossier.where(:aasm_state => "committed")
  end
end
