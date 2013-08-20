class CoursesController < ApplicationController
  def new
    @course = Course.new
    @title = "New Course"
    authorize! :create, @course
  end

  def create
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
    @courses = Course.where("starting_date >= :today", {today: Date.today}).order(:starting_date)
    authorize! :index, @courses
    @dossiers = Dossier.where(:aasm_state => "needs_decision")
    @course = Course.find_by_id(params[:id])
    
    #Info for pie charts
    @gender = @course.gender_count
    @passion = @course.score_count(:passion)
    @leadership = @course.score_count(:leadership)
    @tech = @course.score_count(:tech)

    #Logic for Search-by-Hashtag
    if params[:hashtag]
      if params[:hashtag].empty?
        @confirmed = Dossier.joins(:course)
        .where('dossiers.aasm_state = ? or dossiers.aasm_state = ?', "committed", "needs_payment")
        .where('courses.id' => @course.id)
      else
        @confirmed = Dossier.joins(:course)
        .where('dossiers.aasm_state = ? or dossiers.aasm_state = ?', "committed", "needs_payment")
        .where('courses.id' => @course.id).with_hashtag(params[:hashtag])
      end
    else
      @confirmed = Dossier.joins(:course)
      .where('dossiers.aasm_state = ? or dossiers.aasm_state = ?', "committed", "needs_payment")
      .where('courses.id' => @course.id)
    end
  end

  def dashboard
    @title = "Course Dashboard"
    @courses = Course.all
    authorize! :read, @courses
    @course = Course.first

    # velocity data
    if params[:graph] == "weekly"
      @viewed_today     = Course.count_actions("needs review", "this week")
      @viewed_yesterday = Course.count_actions("needs review", "last week")

      @reviewed_today     = Course.count_actions "reviewed", "this week"
      @reviewed_yesterday = Course.count_actions "reviewed", "last week"

      @interviewed_today     = Course.count_actions("needs decision", "this week")
      @interviewed_yesterday = Course.count_actions("needs decision", "last week")

      @resolved_today     = Course.count_actions "resolved", "this week"
      @resolved_yesterday = Course.count_actions "resolved", "last week"     
    else
      @viewed_today     = Course.count_actions("needs review", "today")
      @viewed_yesterday = Course.count_actions("needs review", "yesterday")

      @reviewed_today     = Course.count_actions "reviewed", "today"
      @reviewed_yesterday = Course.count_actions "reviewed", "yesterday"

      @interviewed_today     = Course.count_actions("needs decision", "today")
      @interviewed_yesterday = Course.count_actions("needs decision", "yesterday")

      @resolved_today     = Course.count_actions "resolved", "today"
      @resolved_yesterday = Course.count_actions "resolved", "yesterday"
    end

  end

end
