# create 3 courses
Course.create(:season => "Fall 2013", :seats => 32, :subject => "Rails", :starting_date => Date.new(2013, 9, 23))
Course.create(:season => "Fall 2013", :seats => 20, :subject => "iOS", :starting_date => Date.new(2013, 9, 30))
Course.create(:season => "Spring 2014", :seats => 30, :subject => "Rails", :starting_date => Date.new(2014, 2, 3))

male_names = ["tom", "alex", "max", "joe"]
men = HTTParty.get(
 "https://api.github.com/legacy/user/search/#{male_names.sample}"
)["users"].collect{|u| u['gravatar_id']}

female_names = ["sally", "samantha", "sarah", "kristen"]
women = HTTParty.get(
  "https://api.github.com/legacy/user/search/#{female_names.sample}"
)["users"].collect{|u| u['gravatar_id']}

rubies = HTTParty.get(
  "https://api.github.com/legacy/user/search/ruby"
)["users"].collect{|u| u['gravatar_id']}

gravatar_ids = {
  "male" => men,
  "female" => women,
  "other" => rubies
}

# create two admins
adam = User.create(
  :first_name => "Adam",
  :last_name => "Enbar",
  :email => "Adam@adam.com",
  :roles => 0,
  :password => "adam"
  )

avi = User.create(
  :first_name => "Avi",
  :last_name => "Flombaum",
  :email => "avi@avi.com",
  :roles => 0,
  :password => "avi"
  )

adam_and_avi = [adam, avi]
example_hashtags = ["lol", "wow", "wtf", "weirdo", "winner", "cool", "smart", "charismatic", "passionate", "unsure", "wonderful", "love", "omg", "genius", "deliberate", "apt", "loser", "GA", "wack", "dunno"]
genders = ["male", "female", "other", "male", "female"]
courses = Course.all
scores = [1, 2, 3, 4, 5]
nycs = ['yes', 'no', 'maybe']

# create 200 users with one dossier each
200.times do |i|
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email

  user.password = Populator.words(1)
  user.set_role(:applicant)

  city = [Faker::Address.city, "NYC", "Brooklyn", "Queens", "New Jersey"].sample
  gender = genders.sample

  user.gravatar_id = gravatar_ids[gender].shift || gravatar_ids["other"].shift || ""

  user.dossiers.build({
    :tagline            => Faker::Company.bs + Faker::Company.bs + Faker::Company.bs,
    :phone_number       => Faker::PhoneNumber.phone_number, #10.times.map{rand(9)}.insert(3, "-").insert(7, "-").join,
    :city               => city,
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
    :skype              => "#{Populator.words(1)}#{rand(999)}",
    :gender             => gender,
    :treehouse_link     => "http://teamtreehouse.com/josephgiralt.json",
    :codeschool_link    => "http://www.codeschool.com/users/alosaperau.json",
    :nyc                => nycs.sample
  })

  user.save

  # picks a random status for the last dossier
  # and moves it thru the states to arrive there
  # with a history
  user.last_dossier.random_status!
  user.last_dossier.create_score(:leadership => scores.sample, :tech => scores.sample, :passion => scores.sample)

  # add 3 hashtags to dossier
  3.times do
    user.last_dossier.add_hashtag example_hashtags.sample, adam_and_avi.sample
  end
  user.last_dossier.add_hashtag( user.last_dossier.gender, adam_and_avi.sample)
end

dhh = User.last
dhh.email = "dhh@dhh.com"
dhh.password = "dhh"
dhh.save

to_interview = Dossier.where("aasm_state" => "needs_interview").all

to_interview.each do |dossier|
  Interview.create(user: adam, dossier: dossier, :stage => dossier.aasm_state)
end

interviews = Interview.all

interviews[0..4].each do |interview|
  interview.interview_time = DateTime.now + 1.day
  interview.save
end

interviews[5..9].each do |interview|
  interview.interview_time = DateTime.now - 1.day
  interview.save
end