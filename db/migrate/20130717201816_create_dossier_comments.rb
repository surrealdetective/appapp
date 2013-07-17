class CreateDossierComments < ActiveRecord::Migration
  def change
    create_table :dossier_comments do |t|
      t.integer :dossier_id
      t.text :content

      t.timestamps
    end
  end
end