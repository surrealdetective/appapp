class AddDateColumnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :open_admissions_date, :date
    add_column :courses, :starting_date, :date
  end
end