class RenameDossierStatusesStateToDossierStatusesStatus < ActiveRecord::Migration
  def change
    rename_column :dossier_statuses, :state, :status
  end
end
