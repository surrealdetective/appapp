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
    redirect_to course_path(Course.where("starting_date >= :today", {today: Date.today}).order(:starting_date).first)
  end

  def show
    @title = "All Courses"
    #for needs decision
    # raise params.inspect
    @dossiers = Dossier.where(:aasm_state => "needs_decision")
    @courses = Course.all
    authorize! :index, @courses

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
        .where('dossiers.aasm_state = ? or dossiers.aasm_state = ?', "committed", "needs_payment")
        .where('courses.id' => @course.id)
      else
        @course = @courses[params[:course].to_i]
        @confirmed = Dossier.joins(:course)
        .where('dossiers.aasm_state = ? or dossiers.aasm_state = ?', "committed", "needs_payment")
        .where('courses.id' => @course.id).with_hashtag(params[:hashtag])
      end
    else
      @course = @courses[params[:course].to_i]
      @confirmed = Dossier.joins(:course)
      .where('dossiers.aasm_state = ? or dossiers.aasm_state = ?', "committed", "needs_payment")
      .where('courses.id' => @course.id)
    end
  end

  def dashboard
    @title = "Course Dashboard"
    @courses = Course.all
    @course = Course.first

    # gender breakdown data
    @male_count = Course.joins(:dossiers).where("dossiers.gender" => "male").count
    @female_count = Course.joins(:dossiers).where("dossiers.gender" => "female").count
    @other_count = Course.joins(:dossiers).where("dossiers.gender" => "other").count

    # velocity data
    @accepted_today = Course.count_actions("accepted", "today")
    @accepted_yesterday = Course.count_actions("accepted", "yesterday")

    @rejected_today = Course.count_actions("rejected", "today")
    @rejected_yesterday = Course.count_actions("rejected", "yesterday")
  end

end
