class RemovePassionScoreLeadershipScoreTechnicalScoreFromDossiers < ActiveRecord::Migration
  def up
    remove_column :dossiers, :passion_score
    remove_column :dossiers, :leadership_score
    remove_column :dossiers, :technical_score
  end

  def down
    add_column :dossiers, :technical_score, :integer
    add_column :dossiers, :leadership_score, :integer
    add_column :dossiers, :passion_score, :integer
  end
end
