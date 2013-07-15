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
# joe.save_with_status("created") #update the status

joes_dossier = Dossier.new
joes_dossier.tagline = "I need a better tagline!"
joe.dossiers << joes_dossier
joe.save

# joe.dossiers.build(tagline: "I need a better tagline")
# joe.save_with_status("filled out dossier")



# joe.application = Application.new
# # joe.current_status = "created" by default
# # user has_one application (??)
# joe.user_attributes.build(:tagline => "From there to here")
# joe_app.save_app #this updates the status again

# #joe.statuses.build(:name => "submitted")
# #joe_app.save