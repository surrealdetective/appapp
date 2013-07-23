class AddSemesterColumnToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :semester, :string
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
  end
end
