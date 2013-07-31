class AddInterviewTimeColumnToInterviews < ActiveRecord::Migration
  def change
    add_column :interviews, :interview_time, :datetime
  end
end
