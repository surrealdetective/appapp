class AddsCodeschoolLinkTreehouseLinkToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :codeschool_link, :string
    add_column :dossiers, :treehouse_link, :string
  end
end
