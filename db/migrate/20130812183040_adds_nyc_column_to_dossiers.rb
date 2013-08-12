class AddsNycColumnToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :nyc, :string
  end
end
