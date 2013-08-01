class AddPassionScoreLeadershipScoreTechnicalScoreToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :passion_score, :integer
    add_column :dossiers, :leadership_score, :integer
    add_column :dossiers, :technical_score, :integer
  end
end
