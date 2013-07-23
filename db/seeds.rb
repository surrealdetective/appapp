require 'populator'
require 'faker'
require 'debugger'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)






User.populate(700) do |user|
  dude = User.new
  dude.name = Populator.words(2)
  # u = user.name
  dude.email = "#{(Populator.words(1))}@#{(Populator.words(1))}.dev"
  dude.dossiers.build(:tagline => "hi")
  dude.dossiers.build(:phone_number => "#{rand(999)}-#{rand(999)}-#{rand(9999)}")
  dude.dossiers.build(:city => "#{Populator.words(1)}")
  dude.dossiers.build(:twitter => "@#{Populator.words(1)}#{rand(999)}")
  dude.dossiers.build(:linkedin => "http://www.linkedin.com/in/#{Populator.words(1)}#{rand(999)}")
  dude.dossiers.build(:blog => "http:#{Populator.words(1)}#{rand(999)}.tumblr.com")
  dude.dossiers.build(:github => "https://github.com/#{Populator.words(1)}#{rand(999)}")
  dude.dossiers.build(:website =>"http://www.#{Populator.words(1)}#{rand(999)}.io")
  dude.dossiers.build(:other_links => "http:#{Populator.words(1)}#{rand(999)}.tumblr.com")
  dude.dossiers.build(:career => "#{Populator.paragraphs(3)}")
  dude.dossiers.build(:purpose => "#{Populator.paragraphs(3)}")
  dude.dossiers.build(:code_skills => "#{Populator.paragraphs(3)}")
  dude.dossiers.build(:analytic_skills => "#{Populator.paragraphs(3)}")
  dude.dossiers.build(:tidbits => "#{Populator.paragraphs(3)}")
  dude.save
end




# #joe is created
# joe = User.new
# joe.name = "Joe Giralt"
# joe.email = "joegiralt@gmail.com"

#joe is created



# max = User.new
# max.name = "Max Jacobson"
# max.email = "maxjacobson@maxwhatever.com"
# max.dossiers.build(:tagline => "Goofy's kid")
# max.save_with_dossier_status("submitted")

# alex = User.new
# alex.name = "Alex Au"
# alex.email = "alex@alexoo.com"
# alexs_dossier = Dossier.new
# alexs_dossier.tagline = "get lucky"
# alex.dossiers << alexs_dossier
# alex.save_with_dossier_status("submitted")

# sam = User.new
# sam.name = "Sam Rad"
# sam.email = "sam@sammo.com"
# sam.dossiers.build(tagline: "Stun me")
# sam.save_with_dossier_status("submitted")

# #miley is submitted
# miley = User.new
# miley.name = "Miley Cyrus"
# miley.email = "miley@twerk.com"
# miley.dossiers.build(tagline: "Just can't stop")
# miley.save_with_dossier_status("submitted")

# dhh = User.new
# dhh.name = "DHH"
# dhh.email = "dhh@icreatedrails.com"
# dhh.dossiers.build(tagline: "Racecars")
# dhh.save_with_dossier_status("submitted")

# # some applicants are reviewed
# alex.save_with_dossier_status("reviewed")
# sam.save_with_dossier_status("reviewed")
# max.save_with_dossier_status("reviewed")
# dhh.save_with_dossier_status("reviewed")

# #sam is accepted
# #max is deferred
# #dhh is declined
# sam.save_with_dossier_status("accepted")
# max.save_with_dossier_status("deferred")
# dhh.save_with_dossier_status("declined")


=======
max = User.new
max.name = "Max Jacobson"
max.email = "maxjacobson@maxwhatever.com"
max.dossiers.build(:tagline => "Goofy's kid")
max.password = 'macman'
max.save_with_dossier_status("submitted")

alex = User.new
alex.name = "Alex Au"
alex.email = "alex@alexoo.com"
alex.password = 'myman'
alexs_dossier = Dossier.new
alexs_dossier.tagline = "get lucky"
alex.dossiers << alexs_dossier
alex.save_with_dossier_status("submitted")

sam = User.new
sam.name = "Sam Rad"
sam.email = "sam@sammo.com"
sam.password = 'sammy'
sam.dossiers.build(tagline: "Stun me")
sam.save_with_dossier_status("submitted")

#miley is submitted
miley = User.new
miley.name = "Miley Cyrus"
miley.email = "miley@twerk.com"
miley.password = 'lights'
miley.dossiers.build(tagline: "Just can't stop")
miley.save_with_dossier_status("submitted")

dhh = User.new
dhh.name = "DHH"
dhh.email = "dhh@icreatedrails.com"
dhh.password = 'roarrr'
dhh.dossiers.build(tagline: "Racecars")
dhh.save_with_dossier_status("submitted")

# some applicants are reviewed
alex.save_with_dossier_status("reviewed")
sam.save_with_dossier_status("reviewed")
max.save_with_dossier_status("reviewed")
dhh.save_with_dossier_status("reviewed")

#sam is accepted
#max is deferred
#dhh is declined
sam.save_with_dossier_status("accepted")
max.save_with_dossier_status("deferred")
dhh.save_with_dossier_status("declined")
>>>>>>> 3ae4e50e76ec3e6fdf3d4ea6480dc7604ec21b2c

100.times do
end
