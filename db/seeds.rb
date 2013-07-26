require 'faker'

classes = ["Fall 2013", "Spring 2014", "Summer 2014"]



300.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = Populator.words(1)
  user.set_role(:applicant)

  city = [Faker::Address.city, "NYC", "Brooklyn", "Queens", "New Jersey"]

  user.dossiers.build({
    :tagline            => Faker::Company.bs,
    :phone_number       => Faker::PhoneNumber.phone_number, #10.times.map{rand(9)}.insert(3, "-").insert(7, "-").join,
    :city               => city.sample,
    :twitter            => Faker::Internet.user_name,
    :linkedin           => "http://www.linkedin.com/in/#{Populator.words(1)}#{rand(999)}",
    :blog               => "http:#{Populator.words(1)}#{rand(999)}.tumblr.com",
    :github             => "https://github.com/#{Populator.words(1)}#{rand(999)}",
    :website            => "http://www.#{Populator.words(1)}#{rand(999)}.io",
    :other_links        => "http://#{Populator.words(1)}#{rand(999)}.#{["wordpress.com", "github.io", "tumblr.com", "typepad.com", "blogspot.com"].sample}",
    :career             => Populator.paragraphs(3),
    :purpose            => Faker::Company.bs,
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






