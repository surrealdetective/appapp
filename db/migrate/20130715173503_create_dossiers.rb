class CreateDossiers < ActiveRecord::Migration
  def change
    create_table :dossiers do |t|
      t.integer :user_id
      t.string :tagline

      t.timestamps
    end
  end
end


