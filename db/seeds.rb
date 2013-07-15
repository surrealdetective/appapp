# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

joe = User.new
joe.name = "Joe Giralt"
joe.email = "joegiralt@gmail.com"
joe.save_with_status("created") #update the status
joes_dossier = Dossier.new
joes_dossier.tagline = "I need a better tagline!"
joe.dossiers << joes_dossier
joe.save_with_status("submitted")

max = User.new
max.name = "Max Jacobson"
max.email = "maxjacobson@maxwhatever.com"
max.save_with_status("created")
max.dossiers.build(:tagline => "Goofy's kid")
max.save_with_status("submitted")

alex = User.new
alex.name = "Alex Au"
alex.email = "alex@alexoo.com"
alex.save_with_status("created")
alexs_dossier = Dossier.new
alexs_dossier.tagline = "get lucky"
alex.dossiers << alexs_dossier
alex.save_with_status("submitted")

sam = User.new
sam.name = "Sam Rad"
sam.email = "sam@sammo.com"
sam.save_with_status("created")
sam.dossiers.build(tagline: "Stun me")
sam.save_with_status("submitted")

alex.save_with_status("reviewed")
sam.save_with_status("reviewed")