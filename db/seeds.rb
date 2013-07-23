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
  user
  user.first_name = Populator.words(1)
  user.last_name = Populator.words(1)
  user.email = "#{(Populator.words(1))}@#{(Populator.words(1))}.dev"
end
counter = 0
classes = ["Fall 2013", "Spring 2014", "Summer 2014"]
Dossier.populate(700) do |dude|
   counter = counter + 1
   dude.user_id = counter 
   dude.tagline = "holy christ we are all the same"
   dude.phone_number = "#{rand(999)}-#{rand(999)}-#{rand(9999)}"
   dude.city = "#{Populator.words(1)}"
   dude.twitter = "@#{Populator.words(1)}#{rand(999)}"
   dude.linkedin = "http://www.linkedin.com/in/#{Populator.words(1)}#{rand(999)}"
   dude.blog = "http:#{Populator.words(1)}#{rand(999)}.tumblr.com"
   dude.github = "https://github.com/#{Populator.words(1)}#{rand(999)}"
   dude.website ="http://www.#{Populator.words(1)}#{rand(999)}.io"
   dude.other_links = "http://#{Populator.words(1)}#{rand(999)}.tumblr.com"
   dude.career = "#{Populator.paragraphs(3)}"
   dude.purpose = "#{Populator.paragraphs(3)}"
   dude.code_skills = "#{Populator.paragraphs(3)}"
   dude.analytic_skills = "#{Populator.paragraphs(3)}"
   dude.tidbits = "#{Populator.paragraphs(3)}"
   dude.semester = classes[rand(0..2)]
end

