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

300.times do
  user = User.new
  user.name = Populator.words(2)
  user.email = "#{(Populator.words(1))}@#{(Populator.words(1))}.dev"
  user.password = Populator.words(1)

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
    :tidbits            => "#{Populator.paragraphs(3)}"
  })
  user.save
end