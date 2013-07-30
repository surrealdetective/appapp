module CoursesHelper

  def course_count_by_state(status, course)
    Course.joins(:dossiers).where("courses.id" => course.id).where("dossiers.aasm_state" => status).count
  end

  def course_count_all(course)
    Course.joins(:dossiers).where("courses.id" => course.id).count  
  end
  
end
