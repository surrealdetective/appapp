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
    #for needs decision
    @dossiers = Dossier.where(:aasm_state => "needs_decision")

    # for class
    @pending = Dossier.where(:aasm_state => "needs_payment")
    # authorize! :index, @pending
    @courses = Course.all

    if params[:hashtag].empty?
      @confirmed = Dossier.where(:aasm_state => "committed")
    elsif params[:hashtag]
      @confirmed = Dossier.where(:aasm_state => "committed").with_hashtag(params[:hashtag])
    else
      @confirmed = Dossier.where(:aasm_state => "committed")
    end
  end

  def dashboard
    @course = Course.first
  end

end
