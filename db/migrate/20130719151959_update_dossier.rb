class UpdateDossier < ActiveRecord::Migration
  def change
    rename_column :dossiers, :question_1, :career
    rename_column :dossiers, :question_2, :purpose
    rename_column :dossiers, :question_3, :code_skills
    rename_column :dossiers, :question_4, :analytic_skills
    rename_column :dossiers, :question_5, :tidbits
    rename_column :dossiers, :city_location, :city
    rename_column :dossiers, :twitter_URL, :twitter
    rename_column :dossiers, :github_url, :github
    rename_column :dossiers, :blog_URL, :blog
    rename_column :dossiers, :website_URL, :website
    rename_column :dossiers, :linkedin_URL, :linkedin
  end
end
