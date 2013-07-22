class ChangeDossierStatusAasmStateToStatus < ActiveRecord::Migration
  def change
    rename_column :dossier_statuses, :aasm_state, :status
  end
end
