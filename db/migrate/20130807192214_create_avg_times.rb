class CreateAvgTimes < ActiveRecord::Migration
  def change
    create_table :avg_times do |t|
      t.integer :course_id
      t.string :status
      t.integer :avg_time_in
      t.integer :count

      t.timestamps
    end
  end
end
