classes = ["Fall 2013", "Spring 2014", "Summer 2014"]

300.times do
  user = User.new
  user.first_name = Populator.words(1)
  user.last_name = Populator.words(1)
  user.email = "#{(Populator.words(1))}@#{(Populator.words(1))}.dev"
  user.password = Populator.words(1)
  user.set_role(:applicant)

  user.dossiers.build({
    :tagline            => Populator.words(10),
    :phone_number       => 10.times.map{rand(9)}.insert(3, "-").insert(7, "-").join,
    :city               => Populator.words(1),
    :twitter            => Populator.words(1),
    :linkedin           => "http://www.linkedin.com/in/#{Populator.words(1)}#{rand(999)}",
    :blog               => "http:#{Populator.words(1)}#{rand(999)}.tumblr.com",
    :github             => "https://github.com/#{Populator.words(1)}#{rand(999)}",
    :website            => "http://www.#{Populator.words(1)}#{rand(999)}.io",
    :other_links        => "http://#{Populator.words(1)}#{rand(999)}.#{["wordpress.com", "github.io", "tumblr.com", "typepad.com", "blogspot.com"].sample}",
    :career             => Populator.paragraphs(3),
    :purpose            => Populator.paragraphs(3),
    :code_skills        => Populator.paragraphs(3),
    :analytic_skills    => Populator.paragraphs(3),
    :tidbits            => Populator.paragraphs(3),
    :semester           => classes.sample
  })

  user.last_dossier.aasm_state = Dossier.aasm.states.sample.to_s


  user.save
end

# our faithful admin
User.create(:first_name => "Adam", :last_name=> "Enbar", :email => "Adam@adam.com", :roles => 0, :password => "adam")
# our plucky young rubyist, yet to fill out an application
User.create(:first_name => "DHH", :last_name=>"Racecars", :email => "dhh@dhh.com", :roles => 200, :password => "dhh")






