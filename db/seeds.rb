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

classes = ["Fall 2013", "Spring 2014", "Summer 2014"]

300.times do
  user = User.new
  user.first_name = Populator.words(1)
  user.last_name = Populator.words(1)
  user.email = "#{(Populator.words(1))}@#{(Populator.words(1))}.dev"
  user.password = Populator.words(1)
  user.roles = 200

  user.dossiers.build({
    :tagline            => Populator.words(10),
    :phone_number       => "#{rand(999)}-#{rand(999)}-#{rand(9999)}",
    :city               => Populator.words(1),
    :twitter            => Populator.words(1),
    :linkedin           => "http://www.linkedin.com/in/#{Populator.words(1)}#{rand(999)}",
    :blog               => "http:#{Populator.words(1)}#{rand(999)}.tumblr.com",
    :github             => "https://github.com/#{Populator.words(1)}#{rand(999)}",
    :website            => "http://www.#{Populator.words(1)}#{rand(999)}.io",
    :other_links        => "http://#{Populator.words(1)}#{rand(999)}.tumblr.com",
    :career             => "#{Populator.paragraphs(3)}",
    :purpose            => "#{Populator.paragraphs(3)}",
    :code_skills        => "#{Populator.paragraphs(3)}",
    :analytic_skills    => "#{Populator.paragraphs(3)}",
    :tidbits            => "#{Populator.paragraphs(3)}",
    :semester           => classes[rand(0..2)]
  })
  user.save
end

User.create(:first_name => "Adam", :last_name=> "Enbar", :email => "Adam@adam.com", :roles => 0, :password => "adam")
User.create(:first_name => "DHH", :last_name=>"Racecars", :email => "dhh@dhh.com", :roles => 200, :password => "dhh")
