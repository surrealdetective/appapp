class RenameInterviewTypeToStage < ActiveRecord::Migration
  def change
    rename_column :interviews, :type, :stage
  end
end
