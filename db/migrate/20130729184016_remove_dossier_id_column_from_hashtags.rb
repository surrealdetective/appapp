class RemoveDossierIdColumnFromHashtags < ActiveRecord::Migration
  def change
    remove_column :hashtags, :dossier_id
    remove_column :hashtags, :user_id

    create_table :user_dossier_hashtags do |t|
      t.integer  :hashtag_id
      t.integer  :dossier_id
      t.integer  :user_id
      
      t.timestamps
    end
  end
end