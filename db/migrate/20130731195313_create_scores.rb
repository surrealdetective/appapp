class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :leadership
      t.integer :tech
      t.integer :passion
      t.integer :dossier_id

      t.timestamps
    end
  end
end
