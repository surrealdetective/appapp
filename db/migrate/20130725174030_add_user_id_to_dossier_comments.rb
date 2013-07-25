class AddUserIdToDossierComments < ActiveRecord::Migration
  def change
    add_column :dossier_comments, :user_id, :integer
  end
end
