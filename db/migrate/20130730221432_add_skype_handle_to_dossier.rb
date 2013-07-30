class AddSkypeHandleToDossier < ActiveRecord::Migration
  def change
    add_column :dossiers, :skype, :string
  end
end
