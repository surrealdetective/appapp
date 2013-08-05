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
    # raise params.inspect
    @dossiers = Dossier.where(:aasm_state => "needs_decision")

    # for class
    @pending = Dossier.where(:aasm_state => "needs_payment")
    # authorize! :index, @pending
    @courses = Course.all
    

    if params[:course]
      @course = @courses[params[:course].to_i]
    else
      @course = @courses.first
    end

#we have a problem here...
  #you send EITHER params[:course] or params[:hashtag]
  # therefore you are NOT searching the current course, which gets automatically
  #set to course[0] when you refresh it.
    if params[:hashtag]
      if params[:hashtag].empty?
        #to be set correctly,
        #@course should equal its position in the index
        @course = @courses[params[:course].to_i]
        @confirmed = Dossier.joins(:course)
        .where('dossiers.aasm_state' => "committed")
        .where('courses.id' => @course.id)
      else
        @course = @courses[params[:course].to_i]
        @confirmed = Dossier.joins(:course)
      .where('dossiers.aasm_state' => "committed")
      .where('courses.id' => @course.id).with_hashtag(params[:hashtag])
      end
    else
      @course = @courses[params[:course].to_i]
      @confirmed = Dossier.joins(:course)
      .where('dossiers.aasm_state' => "committed")
      .where('courses.id' => @course.id)
    end
  end

  def dashboard
    @course = Course.first
  end

end
