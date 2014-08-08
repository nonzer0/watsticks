FactoryGirl.define do
  factory :job do
    title   'key grip'
    company 'showcase cinemas'
    industry 1
    date_applied Date.today
    in_consideration true
  end

  factory :user do
  	sequence(:name)                  { |n| "User #{n}" }
  	sequence(:email)                 { |n| "email_#{n}@test.com" }
  	password              'password'
  	password_confirmation 'password'

    factory :admin do
      admin true
    end
  end
end
