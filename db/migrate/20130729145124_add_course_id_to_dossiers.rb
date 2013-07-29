class AddCourseIdToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :course_id, :integer
    remove_column :dossiers, :semester
  end
end
