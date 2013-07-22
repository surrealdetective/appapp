class AddsAasmStateToDossierTable < ActiveRecord::Migration
  def change
    add_column :dossiers, :aasm_state, :string
  end
end
