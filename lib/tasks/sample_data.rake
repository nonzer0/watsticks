namespace :db do
  desc "Add sample data to database"
  task populate: :environment do
      User.create!(name: "Bjorn Borg",
                   email: "bjorn@tennis.com",
                   password: "tennisanyone",
                   password_confirmation: "tennisanyone",
                   admin: true)

    99.times do |n|
      name = Faker::Name.name
      email = "test" + "#{n+1}" + "@test.com"
      password = "test123"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)

    end

    users = User.all(limit: 7)
    10.times do
      title = Faker::Hacker.noun
      company = Faker::Company.name
      industry = rand(1..2)
      date_applied = Date.today
      users.each { |user| user.jobs.create!(title: title,
                                            company: company,
                                            industry: industry,
                                            date_applied: date_applied) }
    end
  end
end
