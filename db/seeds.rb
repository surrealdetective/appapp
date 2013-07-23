require 'populator'
require 'faker'
require 'debugger'

classes = ["Fall 2013", "Spring 2014", "Summer 2014"]

300.times do
  user = User.new
  user.first_name = Populator.words(1)
  user.last_name = Populator.words(1)
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
    :tidbits            => "#{Populator.paragraphs(3)}",
    :semester           => classes.sample
  })
  user.save
end
