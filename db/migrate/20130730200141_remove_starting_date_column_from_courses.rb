class RemoveStartingDateColumnFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :open_admissions_date
  end
end
