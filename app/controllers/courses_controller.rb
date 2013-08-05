class CoursesController < ApplicationController
  def new
    @course = Course.new
    @title = "New Course"
  end

  def create
    # raise params.inspect
    @course = Course.new(params[:course])
    @course.add_starting_date(params[:date])
    @course.save
    redirect_to courses_path
  end

  def index
    @title = "All Courses"
    #for needs decision
    @dossiers = Dossier.where(:aasm_state => "needs_decision")

    # for class
    @pending = Dossier.where(:aasm_state => "needs_payment")
    # authorize! :index, @pending
    @courses = Course.all
    



    @course = Course.first


    if params[:hashtag]
      if params[:hashtag].empty?
        @confirmed = Dossier.where(:aasm_state => "committed")
      else
        @confirmed = Dossier.where(:aasm_state => "committed").with_hashtag(params[:hashtag])
      end
    else
      @confirmed = Dossier.where(:aasm_state => "committed")
    end
  end

  def dashboard
    @title = "Course Dashboard"
    @course = Course.first
  end

end
