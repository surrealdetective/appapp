module CoursesHelper

  #finds current statuses
  def course_count_by_state(status, course)
    Course.joins(:dossiers).where("courses.id" => course.id).where("dossiers.aasm_state" => status).count
  end

  def course_count_all(course)
    Course.joins(:dossiers).where("courses.id" => course.id).count  
  end

  #finds all statuses that have ever occured
  def course_count_by_state_and_week
    time_range = (Time.now.midnight - 7.day)..Time.now
    Course.joins(dossiers: :dossier_statuses).where('dossier_statuses.status' => 'needs payment').where('courses.id' => 1).where('dossier_statuses.created_at' => time_range).count
  end
  
end
