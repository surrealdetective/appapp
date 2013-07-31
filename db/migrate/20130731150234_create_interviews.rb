class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.integer :user_id
      t.integer :dossier_id
      t.string :type

      t.timestamps
    end
  end
end
