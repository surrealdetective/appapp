class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :subject
      t.string :season
      t.integer :seats

      t.timestamps
    end
  end
end
