class AddGenderColumnToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :gender, :string
  end
end
