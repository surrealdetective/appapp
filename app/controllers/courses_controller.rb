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
    @gender_count = Course.joins(:dossiers).where("courses.id" => @course.id).where("dossiers.gender = ? OR dossiers.gender = ? OR dossiers.gender = ?", "male", "female", "other")
    @male_count = @gender_count.where("dossiers.gender" => "male").count
    @female_count = @gender_count.where("dossiers.gender" => "female").count
    @other_count = @gender_count.where("dossiers.gender" => "other").count

    #use this for all score counts
    @score_counts = Score.joins(:dossier => :course).where("courses.id" => @course.id)

    #use for all passion counts
    @passion_count = @score_counts.where("scores.passion= ? OR scores.passion= ? OR scores.passion= ? OR scores.passion= ? OR scores.passion= ?", 1, 2, 3, 4, 5)

    @passion_one_count = @passion_count.where("scores.passion" => 1).count
    @passion_two_count = @passion_count.where("scores.passion" => 2).count
    @passion_three_count = @passion_count.where("scores.passion" => 3).count
    @passion_four_count = @passion_count.where("scores.passion" => 4).count
    @passion_five_count = @passion_count.where("scores.passion" => 5).count

    @leadership_count = @score_counts.where("scores.leadership = ? OR scores.leadership = ? OR scores.leadership = ? OR scores.leadership = ? OR scores.leadership = ?", 1, 2, 3, 4, 5)

    @leadership_one_count = @leadership_count.where("scores.leadership" => 1).count
    @leadership_two_count = @leadership_count.where("scores.leadership" => 2).count
    @leadership_three_count = @leadership_count.where("scores.leadership" => 3).count
    @leadership_four_count = @leadership_count.where("scores.leadership" => 4).count
    @leadership_five_count = @leadership_count.where("scores.leadership" => 5).count

    @tech_count = @score_counts.where("scores.tech = ? OR scores.tech = ? OR scores.tech = ? OR scores.tech = ? OR scores.tech = ?", 1, 2, 3, 4, 5)

    @tech_one_count = @tech_count.where("scores.tech" => 1).count
    @tech_two_count = @tech_count.where("scores.tech" => 2).count
    @tech_three_count = @tech_count.where("scores.tech" => 3).count
    @tech_four_count = @tech_count.where("scores.tech" => 4).count
    @tech_five_count = @tech_count.where("scores.tech" => 5).count


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
