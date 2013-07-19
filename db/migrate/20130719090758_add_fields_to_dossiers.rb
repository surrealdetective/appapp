class AddFieldsToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :phone_number, :string
    add_column :dossiers, :city_location, :text
    add_column :dossiers, :twitter_URL, :string
    add_column :dossiers, :linkedin_URL, :string
    add_column :dossiers, :blog_URL, :string
    add_column :dossiers, :github_url, :string
    add_column :dossiers, :website_URL, :string
    add_column :dossiers, :other_links, :text
    add_column :dossiers, :question_1, :text
    add_column :dossiers, :question_2, :text
    add_column :dossiers, :question_3, :text
    add_column :dossiers, :question_4, :text
    add_column :dossiers, :question_5, :text
  end
end
