# create 3 courses
Course.create(:season => "Fall 2013", :seats => 32, :subject => "Rails", :starting_date => Date.new(2013, 9, 23))
Course.create(:season => "Fall 2013", :seats => 20, :subject => "iOS", :starting_date => Date.new(2013, 9, 30))
Course.create(:season => "Spring 2014", :seats => 30, :subject => "Rails", :starting_date => Date.new(2014, 2, 3))

# create 300 users with one dossier each

adam = User.create(:first_name => "Adam", :last_name => "Enbar", :email => "Adam@adam.com", :roles => 0, :password => "adam")
avi  = User.create(:first_name => "Avi" , :last_name => "Flombaum", :email => "avi@avi.com", :roles => 100, :password => "avi")


300.times do |i|
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email

  user.password = Populator.words(1)
  user.set_role(:applicant)

  city = [Faker::Address.city, "NYC", "Brooklyn", "Queens", "New Jersey"]
  courses = Course.all

  user.dossiers.build({
    :tagline            => Faker::Company.bs,
    :phone_number       => Faker::PhoneNumber.phone_number, #10.times.map{rand(9)}.insert(3, "-").insert(7, "-").join,
    :city               => city.sample,
    :twitter            => Faker::Internet.user_name,
    :linkedin           => "http://www.linkedin.com/in/#{Populator.words(1)}#{rand(999)}",
    :blog               => "http://#{Populator.words(1)}#{rand(999)}.tumblr.com",
    :github             => "https://github.com/#{Populator.words(1)}#{rand(999)}",
    :website            => "http://www.#{Populator.words(1)}#{rand(999)}.io",
    :other_links        => "http://#{Populator.words(1)}#{rand(999)}.#{["wordpress.com", "github.io", "tumblr.com", "typepad.com", "blogspot.com"].sample}",
    :career             => Populator.paragraphs(3),
    :purpose            => Faker::Company.bs,
    :code_skills        => Populator.paragraphs(3),
    :analytic_skills    => Populator.paragraphs(3),
    :tidbits            => Populator.paragraphs(3),
    :course             => courses.sample,
    :skype              => "#{Populator.words(1)}#{rand(999)}"
  })

  # picks a random status for the last dossier
  # and moves it thru the states to arrive there
  # with a history
  #user.last_dossier.random_status!
  # puts user.inspect
  # puts user.valid?
  #puts user.last_dossier.aasm_state 
  # puts user.last_dossier.valid?

  

  user.save
  5.times do user.last_dossier.hashtags.create(content: Populator.words(1))
  end
end

# our faithful admins
User.create(:first_name => "Adam", :last_name => "Enbar", :email => "Adam@adam.com", :roles => 0, :password => "adam")
User.create(:first_name => "Avi" , :last_name => "Flombaum", :email => "avi@avi.com", :roles => 100, :password => "avi")

# our plucky young rubyist, yet to fill out an application
# not useful until we update the forms to prevent duplicate user creation
# User.create(:first_name => "DHH", :last_name=>"Racecars", :email => "dhh@dhh.com", :roles => 200, :password => "dhh")
