FactoryGirl.define do
  factory :user do
  	sequence(:name)                  { |n| "User #{n}" }
  	sequence(:email)                 { |n| "email_#{n}@test.com" }
  	password              'password'
  	password_confirmation 'password'

    factory :admin do
      admin true
    end

    factory :user_with_jobs do
      after(:create) do |user|
        create(:job, user: user)
      end
    end
  end


  factory :job do
    title   'key grip'
    company 'showcase cinemas'
    industry 1
    date_applied Date.today
    user

    factory :job_with_contacts do
      after(:create) do |job|
        create(:contact, job: job)
      end
    end
  end

  factory :contact do
    name         'Pierre Garcon'
    position     'Slot Receiver'
    email        'pierre@football.com'
    phone_number '555-1212'
  end
end
