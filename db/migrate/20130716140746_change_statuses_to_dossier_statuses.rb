class ChangeStatusesToDossierStatuses < ActiveRecord::Migration
  def change
  
  	rename_table :statuses, :dossier_statuses
  	remove_column :dossier_statuses, :user_id
  	add_column :dossier_statuses, :dossier_id, :integer
  
  end
end
