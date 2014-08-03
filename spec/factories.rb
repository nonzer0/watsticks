FactoryGirl.define do
  factory :job do
    title   'key grip'
    company 'showcase cinemas'
    industry 1
    date_applied Date.today
    in_consideration true
  end

  factory :user do
  	name                  'Free Willy'
  	email                 'willy@shamu.com'
  	password              'password'
  	password_confirmation 'password'
  end
end
