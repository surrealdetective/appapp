class FixColumnName < ActiveRecord::Migration
  def change 
    rename_column :dossier_statuses, :status, :aasm_state
  end
end
