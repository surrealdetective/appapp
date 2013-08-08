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
    @courses = Course.where("starting_date >= :today", {today: Date.today}).order(:starting_date)
    authorize! :index, @courses

    # if params[:course]
    #   @course = @courses[params[:course].to_i]
    # else
    #   @course = Course.find_by_id(params[:id])
    # end

    @course = Course.find_by_id(params[:id])

#we have a problem here...
  #you send EITHER params[:course] or params[:hashtag]
  # therefore you are NOT searching the current course, which gets automatically
  #set to course[0] when you refresh it.
    if params[:hashtag]
      if params[:hashtag].empty?
        #to be set correctly,
        #@course should equal its position in the index
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
    @course = Course.first

    # gender breakdown data
    @male_count = Course.joins(:dossiers).where("dossiers.gender" => "male").count
    @female_count = Course.joins(:dossiers).where("dossiers.gender" => "female").count
    @other_count = Course.joins(:dossiers).where("dossiers.gender" => "other").count

    # velocity data
    @viewed_today = Course.count_actions("needs review", "today")
    @viewed_yesterday = Course.count_actions("needs review", "yesterday")

    @reviewed_today = Course.count_actions("needs interview", "today") + Course.count_actions("needs code interview", "today")
    @reviewed_yesterday = Course.count_actions("needs interview", "yesterday") + Course.count_actions("needs code interview", "yesterday")

    @interviewed_today = Course.count_actions("needs decision", "today")
    @interviewed_yesterday = Course.count_actions("needs decision", "yesterday")

    @resolved_today = Course.count_actions("accepted", "today") + Course.count_actions("rejected", "today") + Course.count_actions("won't attend", "today")
    @resolved_yesterday = Course.count_actions("accepted", "yesterday") + Course.count_actions("rejected", "yesterday") + Course.count_actions("won't attend", "today")
  end

end
