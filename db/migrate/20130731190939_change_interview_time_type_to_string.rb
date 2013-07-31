class ChangeInterviewTimeTypeToString < ActiveRecord::Migration
  def change
    change_column :interviews, :interview_time, :string
  end
end
